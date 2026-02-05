import { models } from "@b/db";

type PriceFeedMode = "offset" | "percent";

type PriceFeedConfig = {
  enabled?: boolean;
  mode?: PriceFeedMode;
  value?: number;
  volatility?: number;
  bias?: number;
};

type ForexMarketRecord = {
  id: string;
  currency: string;
  pair: string;
  name: string;
  category: "FOREX" | "STOCK" | "COMMODITY";
  basePrice: number;
  metadata?: any;
  status: boolean;
};

type TickerData = {
  symbol: string;
  timestamp: number;
  datetime: string;
  high: number;
  low: number;
  bid: number;
  bidVolume: number;
  ask: number;
  askVolume: number;
  vwap: number;
  open: number;
  close: number;
  last: number;
  previousClose: number;
  change: number;
  percentage: number;
  average: number;
  baseVolume: number;
  quoteVolume: number;
  info?: any;
};

const INTERVAL_MS: Record<string, number> = {
  "1m": 60 * 1000,
  "5m": 5 * 60 * 1000,
  "15m": 15 * 60 * 1000,
  "1h": 60 * 60 * 1000,
  "4h": 4 * 60 * 60 * 1000,
  "1d": 24 * 60 * 60 * 1000,
};

function hashStringToUint32(input: string): number {
  let hash = 2166136261;
  for (let i = 0; i < input.length; i++) {
    hash ^= input.charCodeAt(i);
    hash = Math.imul(hash, 16777619);
  }
  return hash >>> 0;
}

function mulberry32(seed: number) {
  return function () {
    let t = (seed += 0x6d2b79f5);
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function seededRandom(key: string): number {
  const seed = hashStringToUint32(key);
  return mulberry32(seed)();
}

function clamp(value: number, min: number) {
  return value < min ? min : value;
}

function getPriceFeedConfig(metadata: any): PriceFeedConfig | null {
  if (!metadata || typeof metadata !== "object") return null;
  const cfg = metadata.priceFeed;
  if (!cfg || typeof cfg !== "object") return null;
  return {
    enabled: !!cfg.enabled,
    mode: cfg.mode === "offset" || cfg.mode === "percent" ? cfg.mode : "percent",
    value: Number(cfg.value || 0),
    volatility: Number(cfg.volatility || 0),
    bias: Number(cfg.bias || 0),
  };
}

function applyPriceFeed(
  basePrice: number,
  config: PriceFeedConfig | null,
  seedKey: string
): number {
  if (!config || !config.enabled) return basePrice;
  const mode = config.mode || "percent";
  const value = Number(config.value || 0);
  const bias = Number(config.bias || 0);
  const volatility = Number(config.volatility || 0);

  const rand = seededRandom(seedKey) - 0.5; // [-0.5, 0.5]

  if (mode === "percent") {
    const volPct = volatility * 0.01 * 2 * rand;
    const factor = 1 + (value + bias) / 100 + volPct;
    return clamp(basePrice * factor, 0.000001);
  }

  // offset mode
  const volOffset = volatility * 2 * rand;
  return clamp(basePrice + value + bias + volOffset, 0.000001);
}

function priceAt(basePrice: number, symbol: string, ts: number): number {
  const day = 24 * 60 * 60 * 1000;
  const hour = 60 * 60 * 1000;
  const phase = (hashStringToUint32(symbol) % 1000) / 1000 * Math.PI * 2;

  const daily = Math.sin((ts / day) * Math.PI * 2 + phase) * 0.0025; // 0.25%
  const hourly = Math.sin((ts / hour) * Math.PI * 2 + phase * 1.7) * 0.0012; // 0.12%
  const noise = (seededRandom(`${symbol}:${Math.floor(ts / 60000)}`) - 0.5) * 0.0008; // 0.08%

  const factor = 1 + daily + hourly + noise;
  return clamp(basePrice * factor, basePrice * 0.2);
}

export class ForexFeedService {
  private static instance: ForexFeedService;
  private markets: Map<string, ForexMarketRecord> = new Map();
  private lastRefresh = 0;
  private refreshIntervalMs = 5000;

  public static getInstance(): ForexFeedService {
    if (!ForexFeedService.instance) {
      ForexFeedService.instance = new ForexFeedService();
    }
    return ForexFeedService.instance;
  }

  private async refreshMarketsIfNeeded() {
    const now = Date.now();
    if (now - this.lastRefresh < this.refreshIntervalMs) return;
    this.lastRefresh = now;

    try {
      const rows = await models.forexMarket.findAll({
        where: { status: true },
        raw: true,
      });
      this.markets.clear();
      rows.forEach((row: any) => {
        const symbol = `${row.currency}/${row.pair}`;
        this.markets.set(symbol, {
          id: row.id,
          currency: row.currency,
          pair: row.pair,
          name: row.name,
          category: row.category,
          basePrice: Number(row.basePrice || 1),
          metadata: row.metadata || null,
          status: row.status,
        });
      });
    } catch (error) {
      // Table might not exist on some deployments; fail gracefully
      console.warn("[ForexFeed] Unable to load markets:", error?.message);
    }
  }

  public async listMarkets(): Promise<ForexMarketRecord[]> {
    await this.refreshMarketsIfNeeded();
    return Array.from(this.markets.values()).map((m) => ({
      ...m,
      metadata: m.metadata || { precision: { price: 4, amount: 2 } },
    }));
  }

  public async getMarket(symbol: string): Promise<ForexMarketRecord | null> {
    await this.refreshMarketsIfNeeded();
    return this.markets.get(symbol) || null;
  }

  public async getTicker(symbol: string): Promise<TickerData | null> {
    const market = await this.getMarket(symbol);
    if (!market) return null;

    const now = Date.now();
    const base = priceAt(market.basePrice, symbol, now);
    const prev = priceAt(market.basePrice, symbol, now - 24 * 60 * 60 * 1000);
    const cfg = getPriceFeedConfig(market.metadata);
    const last = applyPriceFeed(base, cfg, `${symbol}:${now}`);
    const previousClose = applyPriceFeed(prev, cfg, `${symbol}:${now - 86400000}`);

    const change = last - previousClose;
    const percentage = previousClose ? (change / previousClose) * 100 : 0;

    const high = Math.max(last, previousClose);
    const low = Math.min(last, previousClose);

    return {
      symbol,
      timestamp: now,
      datetime: new Date(now).toISOString(),
      high,
      low,
      bid: last * 0.9998,
      bidVolume: 0,
      ask: last * 1.0002,
      askVolume: 0,
      vwap: last,
      open: previousClose,
      close: last,
      last,
      previousClose,
      change,
      percentage,
      average: (last + previousClose) / 2,
      baseVolume: 0,
      quoteVolume: 0,
    };
  }

  public async getTickers(): Promise<Record<string, TickerData>> {
    await this.refreshMarketsIfNeeded();
    const result: Record<string, TickerData> = {};
    for (const symbol of this.markets.keys()) {
      const ticker = await this.getTicker(symbol);
      if (ticker) result[symbol] = ticker;
    }
    return result;
  }

  public async getOHLCV(
    symbol: string,
    interval: string,
    from: number,
    to: number
  ): Promise<number[][]> {
    const market = await this.getMarket(symbol);
    if (!market) return [];
    const intervalMs = INTERVAL_MS[interval] || 60 * 1000;
    const start = Math.floor(from / intervalMs) * intervalMs;
    const end = Math.floor(to / intervalMs) * intervalMs;
    const cfg = getPriceFeedConfig(market.metadata);

    const candles: number[][] = [];
    for (let ts = start; ts <= end; ts += intervalMs) {
      const open = priceAt(market.basePrice, symbol, ts);
      const close = priceAt(market.basePrice, symbol, ts + intervalMs - 1000);
      const p1 = priceAt(market.basePrice, symbol, ts + intervalMs * 0.25);
      const p2 = priceAt(market.basePrice, symbol, ts + intervalMs * 0.5);
      const p3 = priceAt(market.basePrice, symbol, ts + intervalMs * 0.75);
      const high = Math.max(open, close, p1, p2, p3);
      const low = Math.min(open, close, p1, p2, p3);

      const seedKey = `${symbol}:${ts}:candle`;
      const adjOpen = applyPriceFeed(open, cfg, seedKey);
      const adjClose = applyPriceFeed(close, cfg, seedKey);
      const adjHigh = applyPriceFeed(high, cfg, seedKey);
      const adjLow = applyPriceFeed(low, cfg, seedKey);

      const volume =
        100 + seededRandom(`${symbol}:${ts}:vol`) * 1000;

      candles.push([ts, adjOpen, adjHigh, adjLow, adjClose, volume]);
    }
    return candles;
  }

  public async getLatestCandle(
    symbol: string,
    interval: string
  ): Promise<number[] | null> {
    const now = Date.now();
    const intervalMs = INTERVAL_MS[interval] || 60 * 1000;
    const bucket = Math.floor(now / intervalMs) * intervalMs;

    const market = await this.getMarket(symbol);
    if (!market) return null;

    const cfg = getPriceFeedConfig(market.metadata);
    const open = priceAt(market.basePrice, symbol, bucket);
    const close = priceAt(market.basePrice, symbol, now);

    const t1 = Math.min(bucket + intervalMs * 0.25, now);
    const t2 = Math.min(bucket + intervalMs * 0.5, now);
    const t3 = Math.min(bucket + intervalMs * 0.75, now);

    const p1 = priceAt(market.basePrice, symbol, t1);
    const p2 = priceAt(market.basePrice, symbol, t2);
    const p3 = priceAt(market.basePrice, symbol, t3);

    const high = Math.max(open, close, p1, p2, p3);
    const low = Math.min(open, close, p1, p2, p3);

    const seedKey = `${symbol}:${bucket}:candle`;
    const adjOpen = applyPriceFeed(open, cfg, seedKey);
    const adjClose = applyPriceFeed(close, cfg, seedKey);
    const adjHigh = applyPriceFeed(high, cfg, seedKey);
    const adjLow = applyPriceFeed(low, cfg, seedKey);

    const progress = Math.max(0.01, Math.min(1, (now - bucket) / intervalMs));
    const baseVolume = 100 + seededRandom(`${symbol}:${bucket}:vol`) * 1000;
    const volume = baseVolume * progress;

    return [bucket, adjOpen, adjHigh, adjLow, adjClose, volume];
  }

  public async getSyntheticOrderbook(
    symbol: string,
    depth = 50
  ): Promise<{ bids: Array<[number, number]>; asks: Array<[number, number]>; timestamp: number; symbol: string; }> {
    const ticker = await this.getTicker(symbol);
    const mid = ticker?.last || 1;
    const bids: Array<[number, number]> = [];
    const asks: Array<[number, number]> = [];
    for (let i = 1; i <= depth; i++) {
      const delta = mid * 0.0002 * i;
      bids.push([mid - delta, 1 + i * 0.1]);
      asks.push([mid + delta, 1 + i * 0.1]);
    }
    return { bids, asks, timestamp: Date.now(), symbol };
  }
}

export default ForexFeedService.getInstance();
