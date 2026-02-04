interface forexOrderAttributes {
  id: string;
  userId: string;
  status: "OPEN" | "CLOSED" | "CANCELED" | "EXPIRED" | "REJECTED";
  symbol: string;
  type: "MARKET" | "LIMIT";
  timeInForce: "GTC" | "IOC" | "FOK" | "PO";
  side: "BUY" | "SELL";
  price: number;
  average?: number;
  amount: number;
  filled: number;
  remaining: number;
  cost: number;
  trades?: string;
  fee: number;
  feeCurrency: string;
  createdAt?: Date;
  deletedAt?: Date;
  updatedAt?: Date;
}

type forexOrderPk = "id";
type forexOrderId = forexOrderAttributes[forexOrderPk];
type forexOrderOptionalAttributes =
  | "id"
  | "average"
  | "trades"
  | "createdAt"
  | "deletedAt"
  | "updatedAt";
type forexOrderCreationAttributes = Optional<
  forexOrderAttributes,
  forexOrderOptionalAttributes
>;
