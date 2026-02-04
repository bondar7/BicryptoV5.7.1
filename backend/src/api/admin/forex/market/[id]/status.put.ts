import { updateStatus } from "@b/utils/query";

export const metadata = {
  summary: "Updates forex market status",
  operationId: "updateForexMarketStatus",
  tags: ["Admin", "Forex", "Markets"],
  parameters: [
    {
      index: 0,
      name: "id",
      in: "path",
      description: "ID of the forex market to update",
      required: true,
      schema: {
        type: "string",
      },
    },
  ],
  requestBody: {
    description: "New status for the forex market",
    content: {
      "application/json": {
        schema: {
          type: "object",
          properties: {
            status: { type: "boolean" },
          },
        },
      },
    },
  },
  responses: {
    200: { description: "Status updated successfully" },
  },
  requiresAuth: true,
  permission: "access.forex.account",
};

export default async (data) => {
  const { id } = data.params;
  const { status } = data.body;
  return updateStatus("forexMarket", id, status);
};
