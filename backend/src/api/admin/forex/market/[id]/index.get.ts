import { getRecord, notFoundMetadataResponse, serverErrorResponse, unauthorizedResponse } from "@b/utils/query";

export const metadata: OperationObject = {
  summary: "Get Forex Market",
  operationId: "getForexMarket",
  tags: ["Admin", "Forex", "Markets"],
  parameters: [
    {
      index: 0,
      name: "id",
      in: "path",
      required: true,
      description: "Forex market ID",
      schema: { type: "string" },
    },
  ],
  responses: {
    200: { description: "Forex market details" },
    401: unauthorizedResponse,
    404: notFoundMetadataResponse("Forex Market"),
    500: serverErrorResponse,
  },
  requiresAuth: true,
  permission: "access.forex.account",
};

export default async (data: Handler) => {
  return await getRecord("forexMarket", data.params.id);
};
