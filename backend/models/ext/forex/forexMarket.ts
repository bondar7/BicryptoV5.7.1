import * as Sequelize from "sequelize";
import { DataTypes, Model } from "sequelize";

export default class forexMarket
  extends Model<forexMarketAttributes, forexMarketCreationAttributes>
  implements forexMarketAttributes
{
  id!: string;
  currency!: string;
  pair!: string;
  name!: string;
  category!: "FOREX" | "STOCK" | "COMMODITY";
  basePrice!: number;
  metadata?: string;
  status!: boolean;
  createdAt?: Date;
  updatedAt?: Date;
  deletedAt?: Date;

  public static initModel(sequelize: Sequelize.Sequelize): typeof forexMarket {
    return forexMarket.init(
      {
        id: {
          type: DataTypes.UUID,
          defaultValue: DataTypes.UUIDV4,
          primaryKey: true,
          allowNull: false,
        },
        currency: {
          type: DataTypes.STRING(191),
          allowNull: false,
          validate: {
            notEmpty: { msg: "currency: Currency must not be empty" },
          },
          comment: "Base symbol (e.g., EUR, AAPL, XAU)",
        },
        pair: {
          type: DataTypes.STRING(191),
          allowNull: false,
          validate: {
            notEmpty: { msg: "pair: Pair must not be empty" },
          },
          comment: "Quote symbol (e.g., USD)",
        },
        name: {
          type: DataTypes.STRING(191),
          allowNull: false,
          validate: {
            notEmpty: { msg: "name: Name must not be empty" },
          },
          comment: "Display name of the instrument",
        },
        category: {
          type: DataTypes.ENUM("FOREX", "STOCK", "COMMODITY"),
          allowNull: false,
          defaultValue: "FOREX",
          comment: "Asset category",
        },
        basePrice: {
          type: DataTypes.DECIMAL(30, 10),
          allowNull: false,
          defaultValue: 1,
          comment: "Base seed price for demo feed",
        },
        metadata: {
          type: DataTypes.TEXT,
          allowNull: true,
          validate: {
            isJSON(value) {
              try {
                const json = JSON.parse(value);
                if (typeof json !== "object" || json === null) {
                  throw new Error("Metadata must be a valid JSON object.");
                }
              } catch (err) {
                throw new Error(
                  "Metadata must be a valid JSON object: " + err.message
                );
              }
            },
          },
          set(value) {
            this.setDataValue("metadata", JSON.stringify(value));
          },
          get() {
            const value = this.getDataValue("metadata");
            return value ? JSON.parse(value) : null;
          },
          comment: "Additional market configuration and priceFeed settings",
        },
        status: {
          type: DataTypes.BOOLEAN,
          allowNull: false,
          defaultValue: true,
          validate: {
            isBoolean: { msg: "status: Status must be a boolean value" },
          },
          comment: "Market availability status (active/inactive)",
        },
      },
      {
        sequelize,
        modelName: "forexMarket",
        tableName: "forex_market",
        timestamps: true,
        paranoid: true,
        indexes: [
          {
            name: "PRIMARY",
            unique: true,
            using: "BTREE",
            fields: [{ name: "id" }],
          },
          {
            name: "forexMarketCurrencyPairKey",
            unique: true,
            using: "BTREE",
            fields: [{ name: "currency" }, { name: "pair" }],
          },
        ],
      }
    );
  }

  public static associate(models: any) {}
}
