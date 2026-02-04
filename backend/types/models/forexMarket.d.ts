
interface forexMarketAttributes {
  id: string;
  currency: string;
  pair: string;
  name: string;
  category: "FOREX" | "STOCK" | "COMMODITY";
  basePrice: number;
  metadata?: string;
  status: boolean;
  createdAt?: Date;
  updatedAt?: Date;
  deletedAt?: Date;
}

type forexMarketPk = "id";
type forexMarketId = forexMarketAttributes[forexMarketPk];
type forexMarketOptionalAttributes =
  | "id"
  | "metadata"
  | "createdAt"
  | "updatedAt"
  | "deletedAt";
type forexMarketCreationAttributes = Optional<
  forexMarketAttributes,
  forexMarketOptionalAttributes
>;
