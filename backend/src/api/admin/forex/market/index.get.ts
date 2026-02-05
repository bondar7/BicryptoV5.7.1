import { models } from "@b/db";
import { forexMarketSchema } from "./utils";
import {
  getFiltered,
  notFoundMetadataResponse,
  serverErrorResponse,
  unauthorizedResponse,
} from "@b/utils/query";
import { crudParameters, paginationSchema } from "@b/utils/constants";

export const metadata: OperationObject = {
  summary: "List Forex Markets",
  operationId: "listForexMarketsAdmin",
  tags: ["Admin", "Forex", "Markets"],
  description: "Lists all forex demo markets with pagination and filtering.",
  parameters: crudParameters,
  responses: {
    200: {
      description: "Paginated list of forex markets",
      content: {
        "application/json": {
          schema: {
            type: "object",
            properties: {
              items: {
                type: "array",
                items: {
                  type: "object",
                  properties: forexMarketSchema,
                },
              },
              pagination: paginationSchema,
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

export default async (data: Handler) => {
  const { query } = data;
  try {
    return await getFiltered({
      model: models.forexMarket,
      query,
      sortField: query.sortField || "currency",
      timestamps: true,
      paranoid: false,
    });
  } catch (error) {
    console.warn("[Admin Forex Markets] Table not found or error:", error?.message);
    return {
      items: [],
      pagination: {
        totalItems: 0,
        currentPage: Number(query.page) || 1,
        perPage: Number(query.perPage) || 10,
        totalPages: 0,
      },
    };
  }
};
