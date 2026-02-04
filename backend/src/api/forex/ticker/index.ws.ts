import forexFeed from "@b/utils/forexFeed";
import { hasClients, messageBroker } from "@b/handler/Websocket";

export const metadata = {};

class ForexTickerHandler {
  private static instance: ForexTickerHandler;
  private tickerInterval: NodeJS.Timeout | null = null;

  public static getInstance(): ForexTickerHandler {
    if (!ForexTickerHandler.instance) {
      ForexTickerHandler.instance = new ForexTickerHandler();
    }
    return ForexTickerHandler.instance;
  }

  private start() {
    if (this.tickerInterval) return;
    this.tickerInterval = setInterval(async () => {
      if (!hasClients("/api/forex/ticker")) return;
      const tickers = await forexFeed.getTickers();
      messageBroker.broadcastToSubscribedClients(
        "/api/forex/ticker",
        { type: "tickers" },
        { stream: "tickers", data: tickers }
      );
    }, 1000);
  }

  public async handleMessage(message: any) {
    if (typeof message === "string") {
      message = JSON.parse(message);
    }
    if (message?.action === "SUBSCRIBE") {
      this.start();
      // send initial snapshot
      const tickers = await forexFeed.getTickers();
      return { stream: "tickers", data: tickers };
    }
  }
}

export default async (_data: Handler, message: any) => {
  const handler = ForexTickerHandler.getInstance();
  return handler.handleMessage(message);
};
