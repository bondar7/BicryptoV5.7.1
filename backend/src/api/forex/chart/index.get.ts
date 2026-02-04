import forexFeed from "@b/utils/forexFeed";

export const metadata: OperationObject = {
  summary: "Get Forex Historical Chart Data",
  operationId: "getForexHistoricalChartData",
  tags: ["Forex", "Chart"],
  description: "Retrieves historical chart data for forex demo markets.",
  parameters: [
    {
      name: "symbol",
      in: "query",
      description: "Symbol to retrieve data for.",
      required: true,
      schema: { type: "string" },
    },
    {
      name: "interval",
      in: "query",
      description: "Interval to retrieve data for.",
      required: true,
      schema: { type: "string" },
    },
    {
      name: "from",
      in: "query",
      description: "Start timestamp to retrieve data from.",
      required: true,
      schema: { type: "number" },
    },
    {
      name: "to",
      in: "query",
      description: "End timestamp to retrieve data to.",
      required: true,
      schema: { type: "number" },
    },
  ],
  responses: {
    200: {
      description: "Historical chart data retrieved successfully",
      content: {
        "application/json": {
          schema: {
            type: "array",
            items: {
              type: "array",
            },
          },
        },
      },
    },
  },
};

export default async (data: Handler) => {
  const { query } = data;
  if (!query.symbol || !query.interval || !query.from || !query.to) {
    throw new Error("Missing required parameters: symbol, interval, from, to");
  }

  const symbol = query.symbol;
  const interval = query.interval;
  const from = Number(query.from);
  const to = Number(query.to);

  return await forexFeed.getOHLCV(symbol, interval, from, to);
};
