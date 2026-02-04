import { models } from "@b/db";
import {
  notFoundMetadataResponse,
  serverErrorResponse,
  unauthorizedResponse,
} from "@b/utils/query";
import { createError } from "@b/utils/error";

export const metadata: OperationObject = {
  summary: "List Forex Orders",
  operationId: "listForexOrders",
  tags: ["Forex", "Orders"],
  description: "Retrieves forex orders for the authenticated user.",
  parameters: [
    {
      name: "status",
      in: "query",
      description: "Filter by status (e.g., OPEN)",
      required: false,
      schema: { type: "string" },
    },
  ],
  responses: {
    200: {
      description: "List of forex orders",
      content: {
        "application/json": {
          schema: { type: "array", items: { type: "object" } },
        },
      },
    },
    401: unauthorizedResponse,
    404: notFoundMetadataResponse("Forex Order"),
    500: serverErrorResponse,
  },
  requiresAuth: true,
};

export default async (data: Handler) => {
  const { user, query } = data;
  if (!user) throw createError({ statusCode: 401, message: "Unauthorized" });

  const where: any = { userId: user.id };
  if (query?.status) {
    where.status = String(query.status).toUpperCase();
  }

  const orders = await models.forexOrder.findAll({
    where,
    order: [["createdAt", "DESC"]],
  });

  return orders.map((order: any) => order.get({ plain: true }));
};
