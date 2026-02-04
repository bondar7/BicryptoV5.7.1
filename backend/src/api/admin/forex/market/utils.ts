import { baseStringSchema, baseBooleanSchema, baseNumberSchema } from "@b/utils/schema";

const id = baseStringSchema("ID of the forex market");
const currency = baseStringSchema("Base symbol", 191);
const pair = baseStringSchema("Quote symbol", 191);
const name = baseStringSchema("Instrument name", 191);
const category = baseStringSchema("Asset category", 50);
const basePrice = baseNumberSchema("Base seed price");

const metadata = {
  type: "object",
  nullable: true,
  properties: {
    precision: {
      type: "object",
      properties: {
        amount: baseNumberSchema("Amount precision"),
        price: baseNumberSchema("Price precision"),
      },
    },
    priceFeed: {
      type: "object",
      properties: {
        enabled: baseBooleanSchema("Enable price feed modifiers"),
        mode: baseStringSchema("Mode: offset | percent", 20, 0, true),
        value: baseNumberSchema("Base modifier value"),
        volatility: baseNumberSchema("Volatility amount"),
        bias: baseNumberSchema("Bias amount"),
      },
    },
  },
};

const status = baseBooleanSchema("Operational status of the market");

export const forexMarketSchema = {
  id,
  currency,
  pair,
  name,
  category,
  basePrice,
  metadata,
  status,
};

export const ForexMarketUpdateSchema = {
  type: "object",
  properties: {
    currency,
    pair,
    name,
    category,
    basePrice,
    metadata,
    status,
  },
};
