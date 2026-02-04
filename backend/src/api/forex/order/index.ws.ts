import { models } from "@b/db";
import { createError } from "@b/utils/error";

export const metadata = {
  requiresAuth: true,
};

export default async (data: Handler, message: any) => {
  if (typeof message === "string") {
    message = JSON.parse(message);
  }

  const { action, payload } = message || {};
  if (action !== "SUBSCRIBE") return;

  const userId = data?.user?.id;
  if (!userId) {
    throw createError({ statusCode: 401, message: "Unauthorized" });
  }

  if (payload?.userId && payload.userId !== userId) {
    throw createError({ statusCode: 403, message: "Forbidden" });
  }

  const orders = await models.forexOrder.findAll({
    where: { userId },
    order: [["createdAt", "DESC"]],
    limit: 50,
  });

  return {
    stream: "orders",
    data: orders.map((order: any) => order.get({ plain: true })),
  };
};
