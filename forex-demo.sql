-- Forex demo markets seed
-- Safe to run multiple times (uses INSERT ... ON DUPLICATE KEY UPDATE)

CREATE TABLE IF NOT EXISTS `forex_market` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(191) NOT NULL,
  `pair` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `category` enum('FOREX','STOCK','COMMODITY') NOT NULL DEFAULT 'FOREX',
  `basePrice` decimal(30,10) NOT NULL DEFAULT 1,
  `metadata` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forexMarketCurrencyPairKey` (`currency`,`pair`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Forex pairs
INSERT INTO `forex_market`
  (`id`, `currency`, `pair`, `name`, `category`, `basePrice`, `metadata`, `status`, `createdAt`, `updatedAt`)
VALUES
  (UUID(), 'AUD', 'USD', 'AUD/USD', 'FOREX', 0.6600, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'EUR', 'USD', 'EUR/USD', 'FOREX', 1.0800, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'GBP', 'USD', 'GBP/USD', 'FOREX', 1.2600, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'USD', 'CAD', 'USD/CAD', 'FOREX', 1.3500, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'USD', 'CHF', 'USD/CHF', 'FOREX', 0.9100, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'USD', 'JPY', 'USD/JPY', 'FOREX', 150.00, '{"precision":{"price":3,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `basePrice` = VALUES(`basePrice`),
  `metadata` = VALUES(`metadata`),
  `status` = VALUES(`status`),
  `updatedAt` = VALUES(`updatedAt`);

-- Stocks
INSERT INTO `forex_market`
  (`id`, `currency`, `pair`, `name`, `category`, `basePrice`, `metadata`, `status`, `createdAt`, `updatedAt`)
VALUES
  (UUID(), 'BA', 'USD', 'Boeing', 'STOCK', 210.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'CVX', 'USD', 'Chevron', 'STOCK', 150.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'CAT', 'USD', 'Caterpillar', 'STOCK', 300.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'MSFT', 'USD', 'Microsoft', 'STOCK', 430.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'DIS', 'USD', 'Walt Disney', 'STOCK', 95.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'CSCO', 'USD', 'Cisco', 'STOCK', 50.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'GS', 'USD', 'Goldman Sachs', 'STOCK', 380.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'JPM', 'USD', 'JPMorgan', 'STOCK', 190.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'KO', 'USD', 'Coca-Cola', 'STOCK', 60.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'MCD', 'USD', 'McDonalds', 'STOCK', 290.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'MRK', 'USD', 'Merck & Co', 'STOCK', 130.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'AAPL', 'USD', 'Apple', 'STOCK', 190.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'AMZN', 'USD', 'Amazon.com', 'STOCK', 170.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'AMGN', 'USD', 'Amgen', 'STOCK', 300.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'NVDA', 'USD', 'NVIDIA', 'STOCK', 850.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'SHW', 'USD', 'Sherwin-Williams', 'STOCK', 320.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'WMT', 'USD', 'Walmart', 'STOCK', 170.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'HD', 'USD', 'Home Depot', 'STOCK', 350.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'IBM', 'USD', 'IBM', 'STOCK', 170.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'VZ', 'USD', 'Verizon', 'STOCK', 40.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'TRV', 'USD', 'The Travelers', 'STOCK', 220.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'JNJ', 'USD', 'J&J', 'STOCK', 160.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'AXP', 'USD', 'American Express', 'STOCK', 210.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'HON', 'USD', 'Honeywell', 'STOCK', 200.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'CRM', 'USD', 'Salesforce Inc', 'STOCK', 280.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'V', 'USD', 'Visa A', 'STOCK', 270.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'UNH', 'USD', 'UnitedHealth', 'STOCK', 520.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'NKE', 'USD', 'Nike', 'STOCK', 110.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `basePrice` = VALUES(`basePrice`),
  `metadata` = VALUES(`metadata`),
  `status` = VALUES(`status`),
  `updatedAt` = VALUES(`updatedAt`);

-- Commodities
INSERT INTO `forex_market`
  (`id`, `currency`, `pair`, `name`, `category`, `basePrice`, `metadata`, `status`, `createdAt`, `updatedAt`)
VALUES
  (UUID(), 'BRN', 'USD', 'Brent Oil', 'COMMODITY', 82.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'WTI', 'USD', 'WTI Oil', 'COMMODITY', 78.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'NG', 'USD', 'Natural Gas', 'COMMODITY', 2.50, '{"precision":{"price":3,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'XAU', 'USD', 'Gold', 'COMMODITY', 2050.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'XAG', 'USD', 'Silver', 'COMMODITY', 23.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'XCU', 'USD', 'Copper', 'COMMODITY', 4.00, '{"precision":{"price":3,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'COFFEE', 'USD', 'Coffee', 'COMMODITY', 1.80, '{"precision":{"price":3,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'SUGAR', 'USD', 'Sugar', 'COMMODITY', 0.25, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'COCOA', 'USD', 'Cocoa', 'COMMODITY', 3500.00, '{"precision":{"price":2,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW()),
  (UUID(), 'COTTON', 'USD', 'Cotton', 'COMMODITY', 0.85, '{"precision":{"price":4,"amount":2},"priceFeed":{"enabled":false,"mode":"percent","value":0,"volatility":0,"bias":0}}', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `category` = VALUES(`category`),
  `basePrice` = VALUES(`basePrice`),
  `metadata` = VALUES(`metadata`),
  `status` = VALUES(`status`),
  `updatedAt` = VALUES(`updatedAt`);
