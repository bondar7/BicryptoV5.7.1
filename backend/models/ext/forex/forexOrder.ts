import * as Sequelize from "sequelize";
import { DataTypes, Model } from "sequelize";
import user from "../../user";

export interface forexOrderAttributes {
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

export type forexOrderPk = "id";
export type forexOrderId = forexOrder[forexOrderPk];
export type forexOrderOptionalAttributes =
  | "id"
  | "average"
  | "trades"
  | "createdAt"
  | "deletedAt"
  | "updatedAt";
export type forexOrderCreationAttributes = Optional<
  forexOrderAttributes,
  forexOrderOptionalAttributes
>;

export default class forexOrder
  extends Model<forexOrderAttributes, forexOrderCreationAttributes>
  implements forexOrderAttributes
{
  id!: string;
  userId!: string;
  status!: "OPEN" | "CLOSED" | "CANCELED" | "EXPIRED" | "REJECTED";
  symbol!: string;
  type!: "MARKET" | "LIMIT";
  timeInForce!: "GTC" | "IOC" | "FOK" | "PO";
  side!: "BUY" | "SELL";
  price!: number;
  average?: number;
  amount!: number;
  filled!: number;
  remaining!: number;
  cost!: number;
  trades?: string;
  fee!: number;
  feeCurrency!: string;
  createdAt?: Date;
  deletedAt?: Date;
  updatedAt?: Date;

  user!: user;
  getUser!: Sequelize.BelongsToGetAssociationMixin<user>;
  setUser!: Sequelize.BelongsToSetAssociationMixin<user, userId>;
  createUser!: Sequelize.BelongsToCreateAssociationMixin<user>;

  public static initModel(sequelize: Sequelize.Sequelize): typeof forexOrder {
    return forexOrder.init(
      {
        id: {
          type: DataTypes.UUID,
          defaultValue: DataTypes.UUIDV4,
          primaryKey: true,
          allowNull: false,
        },
        userId: {
          type: DataTypes.UUID,
          allowNull: false,
          validate: {
            notNull: { msg: "userId: User ID cannot be null" },
            isUUID: { args: 4, msg: "userId: User ID must be a valid UUID" },
          },
          comment: "ID of the user who placed this order",
        },
        status: {
          type: DataTypes.ENUM(
            "OPEN",
            "CLOSED",
            "CANCELED",
            "EXPIRED",
            "REJECTED"
          ),
          allowNull: false,
          defaultValue: "CLOSED",
          validate: {
            isIn: {
              args: [["OPEN", "CLOSED", "CANCELED", "EXPIRED", "REJECTED"]],
              msg: "status: Must be one of OPEN, CLOSED, CANCELED, EXPIRED, REJECTED",
            },
          },
          comment: "Current status of the forex order",
        },
        symbol: {
          type: DataTypes.STRING(191),
          allowNull: false,
          validate: {
            notEmpty: { msg: "symbol: Symbol cannot be empty" },
          },
          comment: "Market symbol (e.g., EUR/USD)",
        },
        type: {
          type: DataTypes.ENUM("MARKET", "LIMIT"),
          allowNull: false,
          defaultValue: "MARKET",
          validate: {
            isIn: { args: [["MARKET", "LIMIT"]], msg: "type: Invalid order type" },
          },
          comment: "Order type",
        },
        timeInForce: {
          type: DataTypes.ENUM("GTC", "IOC", "FOK", "PO"),
          allowNull: false,
          defaultValue: "GTC",
          comment: "Time in force",
        },
        side: {
          type: DataTypes.ENUM("BUY", "SELL"),
          allowNull: false,
          validate: {
            isIn: { args: [["BUY", "SELL"]], msg: "side: Invalid order side" },
          },
          comment: "Order side",
        },
        price: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          comment: "Order price",
        },
        average: {
          type: DataTypes.DOUBLE,
          allowNull: true,
          comment: "Average fill price",
        },
        amount: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          comment: "Order amount",
        },
        filled: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          defaultValue: 0,
          comment: "Filled amount",
        },
        remaining: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          defaultValue: 0,
          comment: "Remaining amount",
        },
        cost: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          comment: "Order cost",
        },
        trades: {
          type: DataTypes.TEXT,
          allowNull: true,
          comment: "Serialized trades",
        },
        fee: {
          type: DataTypes.DOUBLE,
          allowNull: false,
          defaultValue: 0,
          comment: "Order fee",
        },
        feeCurrency: {
          type: DataTypes.STRING(191),
          allowNull: true,
          comment: "Fee currency",
        },
      },
      {
        sequelize,
        modelName: "forexOrder",
        tableName: "forex_order",
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
            name: "forexOrderUserIdIdx",
            using: "BTREE",
            fields: [{ name: "userId" }],
          },
          {
            name: "forexOrderSymbolIdx",
            using: "BTREE",
            fields: [{ name: "symbol" }],
          },
        ],
      }
    );
  }

  public static associate(models: any) {
    forexOrder.belongsTo(models.user, {
      as: "user",
      foreignKey: "userId",
    });
  }
}
