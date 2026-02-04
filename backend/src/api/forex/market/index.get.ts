import forexFeed from "@b/utils/forexFeed";

export const metadata: OperationObject = {
  summary: "List Forex Markets",
  operationId: "listForexMarkets",
  tags: ["Forex", "Markets"],
  description: "Retrieves a list of all available forex demo markets.",
  responses: {
    200: {
      description: "A list of forex markets",
      content: {
        "application/json": {
          schema: {
            type: "array",
            items: { type: "object" },
          },
        },
      },
    },
  },
};

export default async () => {
  const markets = await forexFeed.listMarkets();
  return markets.map((market) => ({
    ...market,
    symbol: `${market.currency}/${market.pair}`,
  }));
};
