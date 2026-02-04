-- Forex orders table

CREATE TABLE IF NOT EXISTS `forex_order` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('OPEN','CLOSED','CANCELED','EXPIRED','REJECTED') NOT NULL DEFAULT 'CLOSED',
  `symbol` varchar(191) NOT NULL,
  `type` enum('MARKET','LIMIT') NOT NULL DEFAULT 'MARKET',
  `timeInForce` enum('GTC','IOC','FOK','PO') NOT NULL DEFAULT 'GTC',
  `side` enum('BUY','SELL') NOT NULL,
  `price` double NOT NULL,
  `average` double DEFAULT NULL,
  `amount` double NOT NULL,
  `filled` double NOT NULL DEFAULT 0,
  `remaining` double NOT NULL DEFAULT 0,
  `cost` double NOT NULL,
  `trades` text DEFAULT NULL,
  `fee` double NOT NULL DEFAULT 0,
  `feeCurrency` varchar(191) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forexOrderUserIdIdx` (`userId`),
  KEY `forexOrderSymbolIdx` (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
