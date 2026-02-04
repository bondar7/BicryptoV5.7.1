import { models } from "@b/db";
import { forexMarketSchema } from "./utils";
import {
  notFoundMetadataResponse,
  serverErrorResponse,
  unauthorizedResponse,
} from "@b/utils/query";

export const metadata: OperationObject = {
  summary: "List Forex Markets",
  operationId: "listForexMarketsAdmin",
  tags: ["Admin", "Forex", "Markets"],
  description: "Lists all forex demo markets with pagination and filtering.",
  responses: {
    200: {
      description: "List of forex markets",
      content: {
        "application/json": {
          schema: {
            type: "array",
            items: {
              type: "object",
              properties: forexMarketSchema,
            },
          },
        },
      },
    },
    401: unauthorizedResponse,
    404: notFoundMetadataResponse("Forex Market"),
    500: serverErrorResponse,
  },
  requiresAuth: true,
  permission: "access.forex.account",
};

export default async () => {
  try {
    const markets = await models.forexMarket.findAll({
      order: [["currency", "ASC"]],
    });
    return markets.map((m: any) => m.get({ plain: true }));
  } catch (error) {
    console.warn("[Admin Forex Markets] Table not found or error:", error?.message);
    return [];
  }
};
