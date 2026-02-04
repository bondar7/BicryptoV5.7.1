import forexFeed from "@b/utils/forexFeed";
import { messageBroker, hasClients } from "@b/handler/Websocket";
import { models } from "@b/db";

export const metadata = {};

type SubscriptionPayload = {
  type: "ticker" | "ohlcv" | "orderbook" | "trades";
  symbol: string;
  interval?: string;
  limit?: number;
};

class ForexMarketDataHandler {
  private static instance: ForexMarketDataHandler;
  private activeSubscriptions: Map<string, Set<string>> = new Map(); // symbol -> Set<dataTypes>
  private subscriptionParams: Map<string, SubscriptionPayload> = new Map(); // key symbol:type
  private intervalMap: Map<string, NodeJS.Timeout> = new Map(); // symbol -> interval timer

  public static getInstance(): ForexMarketDataHandler {
    if (!ForexMarketDataHandler.instance) {
      ForexMarketDataHandler.instance = new ForexMarketDataHandler();
    }
    return ForexMarketDataHandler.instance;
  }

  private async validateMarket(symbol: string): Promise<boolean> {
    const [currency, pair] = symbol.split("/");
    if (!currency || !pair) return false;
    try {
      const market = await models.forexMarket.findOne({
        where: { currency, pair, status: true },
        raw: true,
      });
      return !!market;
    } catch {
      // Table might not exist on some deployments
      return false;
    }
  }

  private async fetchAndBroadcast(symbol: string) {
    const types = this.activeSubscriptions.get(symbol);
    if (!types || types.size === 0) return;

    const route = "/api/forex/market";
    const payloads = Array.from(types).map((type) =>
      this.subscriptionParams.get(`${symbol}:${type}`)!
    );

    await Promise.all(
      payloads.map(async (payload) => {
        switch (payload.type) {
          case "ticker": {
            const ticker = await forexFeed.getTicker(symbol);
            if (!ticker) return;
            messageBroker.broadcastToSubscribedClients(route, payload, {
              stream: "ticker",
              data: ticker,
            });
            break;
          }
          case "ohlcv": {
            const interval = payload.interval || "1m";
            const candle = await forexFeed.getLatestCandle(symbol, interval);
            if (!candle) return;
            messageBroker.broadcastToSubscribedClients(route, payload, {
              stream: `ohlcv:${interval}`,
              data: [candle],
            });
            break;
          }
          case "orderbook": {
            const depth = payload.limit || 50;
            const orderbook = await forexFeed.getSyntheticOrderbook(
              symbol,
              depth
            );
            messageBroker.broadcastToSubscribedClients(route, payload, {
              stream: payload.limit ? `orderbook:${payload.limit}` : "orderbook",
              data: orderbook,
            });
            break;
          }
          case "trades": {
            messageBroker.broadcastToSubscribedClients(route, payload, {
              stream: "trades",
              data: [],
            });
            break;
          }
        }
      })
    );
  }

  private startLoop(symbol: string) {
    if (this.intervalMap.has(symbol)) return;

    const interval = setInterval(async () => {
      if (!hasClients("/api/forex/market")) return;
      await this.fetchAndBroadcast(symbol);
    }, 1000);

    this.intervalMap.set(symbol, interval);
  }

  public async addSubscription(payload: SubscriptionPayload) {
    const { symbol, type } = payload;
    if (!symbol || !type) return;
    const isValid = await this.validateMarket(symbol);
    if (!isValid) return;

    if (!this.activeSubscriptions.has(symbol)) {
      this.activeSubscriptions.set(symbol, new Set([type]));
      this.startLoop(symbol);
    } else {
      this.activeSubscriptions.get(symbol)!.add(type);
    }

    this.subscriptionParams.set(`${symbol}:${type}`, payload);

    // send initial data immediately
    await this.fetchAndBroadcast(symbol);
  }

  public removeSubscription(symbol: string, type: string) {
    if (!this.activeSubscriptions.has(symbol)) return;
    this.activeSubscriptions.get(symbol)!.delete(type);
    this.subscriptionParams.delete(`${symbol}:${type}`);
    if (this.activeSubscriptions.get(symbol)!.size === 0) {
      this.activeSubscriptions.delete(symbol);
      const interval = this.intervalMap.get(symbol);
      if (interval) clearInterval(interval);
      this.intervalMap.delete(symbol);
    }
  }
}

export default async (_data: Handler, message: any) => {
  if (typeof message === "string") {
    message = JSON.parse(message);
  }

  const { action, payload } = message || {};
  const { type, symbol } = payload || {};
  if (!type || !symbol) return;

  const handler = ForexMarketDataHandler.getInstance();
  if (action === "UNSUBSCRIBE") {
    handler.removeSubscription(symbol, type);
  } else {
    await handler.addSubscription(payload);
  }
};
