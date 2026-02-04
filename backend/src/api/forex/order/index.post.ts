import { models, sequelize } from "@b/db";
import forexFeed from "@b/utils/forexFeed";
import { createRecordResponses } from "@b/utils/query";
import { createError } from "@b/utils/error";
import { messageBroker } from "@b/handler/Websocket";

export const metadata: OperationObject = {
  summary: "Create Forex Order",
  operationId: "createForexOrder",
  tags: ["Forex", "Orders"],
  description: "Creates a local forex order and updates FIAT wallets.",
  requestBody: {
    description: "Order creation data.",
    content: {
      "application/json": {
        schema: {
          type: "object",
          properties: {
            currency: { type: "string" },
            pair: { type: "string" },
            type: { type: "string" },
            side: { type: "string" },
            amount: { type: "number" },
            price: { type: "number" },
          },
          required: ["currency", "pair", "type", "side", "amount"],
        },
      },
    },
    required: true,
  },
  responses: createRecordResponses("Forex Order"),
  requiresAuth: true,
};

async function getOrCreateFiatWallet(userId: string, currency: string, t: any) {
  let wallet = await models.wallet.findOne({
    where: { userId, currency, type: "FIAT" },
    transaction: t,
    lock: t.LOCK.UPDATE,
  });

  if (!wallet) {
    wallet = await models.wallet.create(
      {
        userId,
        type: "FIAT",
        currency,
        balance: 0,
      },
      { transaction: t }
    );
  }

  return wallet;
}

export default async (data: Handler) => {
  const { user, body } = data;
  if (!user) throw createError({ statusCode: 401, message: "Unauthorized" });

  const { currency, pair, amount, price, type, side } = body || {};

  if (!currency || !pair || !type || !side || amount == null) {
    throw createError({ statusCode: 400, message: "Missing required parameters" });
  }

  const normalizedSide = String(side).toUpperCase();
  const normalizedType = String(type).toUpperCase();

  if (!['BUY', 'SELL'].includes(normalizedSide)) {
    throw createError({ statusCode: 400, message: "Invalid order side" });
  }

  if (!['MARKET', 'LIMIT'].includes(normalizedType)) {
    throw createError({ statusCode: 400, message: "Invalid order type" });
  }

  const numericAmount = Number(amount);
  if (!Number.isFinite(numericAmount) || numericAmount <= 0) {
    throw createError({ statusCode: 400, message: "Amount must be greater than zero" });
  }

  const market = await models.forexMarket.findOne({
    where: { currency, pair, status: true },
  });
  if (!market) {
    throw createError({ statusCode: 404, message: "Market not found" });
  }

  const symbol = `${currency}/${pair}`;
  const ticker = await forexFeed.getTicker(symbol);
  const marketPrice = ticker?.last || Number(market.basePrice) || 1;

  const numericPrice = normalizedType === "LIMIT" && price ? Number(price) : marketPrice;
  if (!Number.isFinite(numericPrice) || numericPrice <= 0) {
    throw createError({ statusCode: 400, message: "Price must be greater than zero" });
  }

  const cost = Number((numericAmount * numericPrice).toFixed(8));

  const order = await sequelize.transaction(async (t) => {
    const currencyWallet = await getOrCreateFiatWallet(user.id, currency, t);
    const pairWallet = await getOrCreateFiatWallet(user.id, pair, t);

    if (normalizedSide === "BUY") {
      if (pairWallet.balance < cost) {
        throw createError({ statusCode: 400, message: "Insufficient balance" });
      }
      await pairWallet.update({ balance: pairWallet.balance - cost }, { transaction: t });
      await currencyWallet.update({ balance: currencyWallet.balance + numericAmount }, { transaction: t });
    } else {
      if (currencyWallet.balance < numericAmount) {
        throw createError({ statusCode: 400, message: "Insufficient balance" });
      }
      await currencyWallet.update({ balance: currencyWallet.balance - numericAmount }, { transaction: t });
      await pairWallet.update({ balance: pairWallet.balance + cost }, { transaction: t });
    }

    const created = await models.forexOrder.create(
      {
        userId: user.id,
        status: "CLOSED",
        symbol,
        type: normalizedType,
        timeInForce: "GTC",
        side: normalizedSide,
        price: numericPrice,
        average: numericPrice,
        amount: numericAmount,
        filled: numericAmount,
        remaining: 0,
        cost,
        trades: JSON.stringify([]),
        fee: 0,
        feeCurrency: pair,
      },
      { transaction: t }
    );

    return created.get({ plain: true });
  });

  // Broadcast to subscribed clients
  try {
    messageBroker.broadcastToSubscribedClients(
      "/api/forex/order",
      { type: "orders", userId: user.id },
      { stream: "orders", data: [order] }
    );
  } catch (err) {
    console.warn("[Forex Order] Failed to broadcast order update:", err?.message);
  }

  return order;
};
