import { updateRecord, updateRecordResponses } from "@b/utils/query";
import { ForexMarketUpdateSchema } from "@b/api/admin/forex/market/utils";

export const metadata = {
  summary: "Updates a specific forex market",
  operationId: "updateForexMarket",
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
    description: "New data for the forex market",
    content: {
      "application/json": {
        schema: ForexMarketUpdateSchema,
      },
    },
  },
  responses: updateRecordResponses("Forex Market"),
  requiresAuth: true,
  permission: "access.forex.account",
};

export default async (data) => {
  const { body, params } = data;
  const { id } = params;
  const { currency, pair, name, category, basePrice, metadata, status } = body;

  return await updateRecord("forexMarket", id, {
    currency,
    pair,
    name,
    category,
    basePrice,
    metadata,
    status,
  });
};
