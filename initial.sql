-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2025 at 01:46 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `v5`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_profit`
--

CREATE TABLE `admin_profit` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('DEPOSIT','WITHDRAW','TRANSFER','BINARY_ORDER','EXCHANGE_ORDER','INVESTMENT','AI_INVESTMENT','FOREX_DEPOSIT','FOREX_WITHDRAW','FOREX_INVESTMENT','ICO_CONTRIBUTION','STAKING','P2P_TRADE') NOT NULL COMMENT 'Type of transaction that generated the admin profit',
  `amount` double NOT NULL COMMENT 'Profit amount earned by admin from this transaction',
  `currency` varchar(255) NOT NULL COMMENT 'Currency of the profit amount',
  `chain` varchar(255) DEFAULT NULL COMMENT 'Blockchain network if applicable',
  `description` text DEFAULT NULL COMMENT 'Additional description of the profit source',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_investment`
--

CREATE TABLE `ai_investment` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` double NOT NULL,
  `profit` double DEFAULT NULL,
  `result` enum('WIN','LOSS','DRAW') DEFAULT NULL,
  `status` enum('ACTIVE','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `symbol` varchar(191) NOT NULL,
  `type` enum('SPOT','ECO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_investment_duration`
--

CREATE TABLE `ai_investment_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `duration` int(11) NOT NULL,
  `timeframe` enum('HOUR','DAY','WEEK','MONTH') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_investment_plan`
--

CREATE TABLE `ai_investment_plan` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `invested` int(11) NOT NULL DEFAULT 0,
  `profitPercentage` double NOT NULL DEFAULT 0,
  `minProfit` double NOT NULL,
  `maxProfit` double NOT NULL,
  `minAmount` double NOT NULL DEFAULT 0,
  `maxAmount` double NOT NULL,
  `trending` tinyint(1) DEFAULT 0,
  `defaultProfit` double NOT NULL,
  `defaultResult` enum('WIN','LOSS','DRAW') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_investment_plan_duration`
--

CREATE TABLE `ai_investment_plan_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('GENERAL','EVENT','UPDATE') NOT NULL DEFAULT 'GENERAL',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_key`
--

CREATE TABLE `api_key` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `key` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`permissions`)),
  `ipWhitelist` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ipWhitelist`)),
  `name` varchar(255) NOT NULL,
  `ipRestriction` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('plugin','user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the user who is applying to become a blog author',
  `status` enum('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING' COMMENT 'Current status of the author application (PENDING, APPROVED, REJECTED)',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `binary_duration`
--

CREATE TABLE `binary_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'Duration in minutes for binary option expiry',
  `profitPercentage` double NOT NULL COMMENT 'Profit percentage offered for this duration',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Whether this duration is active and available for trading',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `binary_market`
--

CREATE TABLE `binary_market` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(191) NOT NULL COMMENT 'Base currency symbol (e.g., BTC, ETH)',
  `pair` varchar(191) NOT NULL COMMENT 'Trading pair symbol (e.g., USDT, USD)',
  `isTrending` tinyint(1) DEFAULT 0 COMMENT 'Whether this market is currently trending',
  `isHot` tinyint(1) DEFAULT 0 COMMENT 'Whether this market is marked as hot/popular',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Market availability status (active/inactive)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `binary_order`
--

CREATE TABLE `binary_order` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the user who placed this order',
  `symbol` varchar(191) NOT NULL COMMENT 'Trading currency/pair for the binary option',
  `price` double NOT NULL COMMENT 'Entry price when the order was placed',
  `amount` double NOT NULL COMMENT 'Amount invested in this binary option',
  `profit` double NOT NULL COMMENT 'Potential profit amount from this option',
  `side` enum('RISE','FALL','HIGHER','LOWER','TOUCH','NO_TOUCH','CALL','PUT','UP','DOWN') NOT NULL COMMENT 'Direction/side of the binary option prediction',
  `type` enum('RISE_FALL','HIGHER_LOWER','TOUCH_NO_TOUCH','CALL_PUT','TURBO') NOT NULL COMMENT 'Type of binary option (rise/fall, higher/lower, etc.)',
  `status` enum('PENDING','WIN','LOSS','DRAW','CANCELED') NOT NULL COMMENT 'Current status of the binary option order',
  `isDemo` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether this is a demo/practice order',
  `closedAt` datetime(3) NOT NULL COMMENT 'Date and time when the option expires/closes',
  `closePrice` double DEFAULT NULL COMMENT 'Final price when the option closed',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `durationType` enum('TIME','TICKS') NOT NULL DEFAULT 'TIME' COMMENT 'Duration type - time-based or tick-based',
  `barrier` double DEFAULT NULL COMMENT 'Barrier price level for barrier options',
  `strikePrice` double DEFAULT NULL COMMENT 'Strike price for the binary option',
  `payoutPerPoint` double DEFAULT NULL COMMENT 'Payout amount per point movement'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Display name of the blog category',
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug for the category (used in URLs)',
  `image` text DEFAULT NULL COMMENT 'URL path to the category''s featured image',
  `description` text DEFAULT NULL COMMENT 'Description of the blog category',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` text NOT NULL COMMENT 'Content/text of the comment',
  `postId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the blog post this comment belongs to',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the user who posted this comment',
  `status` enum('APPROVED','PENDING','REJECTED') NOT NULL DEFAULT 'PENDING' COMMENT 'Moderation status of the comment (APPROVED, PENDING, REJECTED)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Full name of the currency (e.g., Bitcoin, US Dollar)',
  `symbol` varchar(191) NOT NULL COMMENT 'Currency symbol/ticker (e.g., BTC, USD, ETH)',
  `precision` double NOT NULL COMMENT 'Number of decimal places for this currency',
  `price` double DEFAULT NULL COMMENT 'Current price of the currency in base currency',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether this currency is active and available for trading'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currency_swap`
--

CREATE TABLE `currency_swap` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `fromCurrency` varchar(3) NOT NULL,
  `toCurrency` varchar(3) NOT NULL,
  `fromAmount` double NOT NULL,
  `toAmount` double NOT NULL,
  `status` enum('PENDING','COMPLETED','FAILED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `default_pages`
--

CREATE TABLE `default_pages` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `pageId` varchar(255) NOT NULL,
  `pageSource` enum('default','builder') NOT NULL DEFAULT 'default' COMMENT 'Source type: default for regular pages, builder for builder-created pages',
  `type` enum('variables','content') NOT NULL,
  `title` varchar(255) NOT NULL,
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Structured data for home page editing (texts, images, etc.)' CHECK (json_valid(`variables`)),
  `content` text DEFAULT NULL COMMENT 'HTML/markdown content for legal pages',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'SEO metadata and other page settings' CHECK (json_valid(`meta`)),
  `status` enum('active','draft') NOT NULL DEFAULT 'active',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_gateway`
--

CREATE TABLE `deposit_gateway` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `alias` varchar(191) DEFAULT NULL,
  `currencies` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`currencies`)),
  `fixedFee` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`fixedFee`)),
  `percentageFee` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`percentageFee`)),
  `minAmount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`minAmount`)),
  `maxAmount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`maxAmount`)),
  `type` enum('FIAT','CRYPTO') NOT NULL DEFAULT 'FIAT',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `version` varchar(191) DEFAULT '0.0.1',
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_method`
--

CREATE TABLE `deposit_method` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'Display name of the deposit method',
  `instructions` text NOT NULL COMMENT 'Step-by-step instructions for using this deposit method',
  `image` varchar(1000) DEFAULT NULL COMMENT 'URL path to the method''s logo or icon',
  `fixedFee` double NOT NULL DEFAULT 0 COMMENT 'Fixed fee amount charged for deposits',
  `percentageFee` double NOT NULL DEFAULT 0 COMMENT 'Percentage fee charged on deposit amount',
  `minAmount` double NOT NULL DEFAULT 0 COMMENT 'Minimum deposit amount allowed',
  `maxAmount` double NOT NULL DEFAULT 0 COMMENT 'Maximum deposit amount allowed',
  `customFields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Custom form fields required for this deposit method' CHECK (json_valid(`customFields`)),
  `status` tinyint(1) DEFAULT 1 COMMENT 'Whether this deposit method is active and available',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_category`
--

CREATE TABLE `ecommerce_category` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `slug` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_discount`
--

CREATE TABLE `ecommerce_discount` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(191) NOT NULL,
  `percentage` int(11) NOT NULL,
  `validUntil` datetime(3) NOT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_order`
--

CREATE TABLE `ecommerce_order` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('PENDING','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `shippingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_order_item`
--

CREATE TABLE `ecommerce_order_item` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `orderId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `quantity` int(11) NOT NULL,
  `key` varchar(191) DEFAULT NULL,
  `filePath` varchar(191) DEFAULT NULL,
  `instructions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_product`
--

CREATE TABLE `ecommerce_product` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `type` enum('DOWNLOADABLE','PHYSICAL') NOT NULL,
  `price` double NOT NULL,
  `categoryId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `inventoryQuantity` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(191) DEFAULT NULL,
  `currency` varchar(191) NOT NULL DEFAULT 'USD',
  `walletType` enum('FIAT','SPOT','ECO') NOT NULL DEFAULT 'SPOT',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `slug` varchar(191) NOT NULL,
  `shortDescription` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_product_variant`
--

CREATE TABLE `ecommerce_product_variant` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `priceModifier` decimal(16,8) DEFAULT 0.00000000,
  `inventoryQuantity` int(11) NOT NULL DEFAULT 0,
  `sku` varchar(100) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_review`
--

CREATE TABLE `ecommerce_review` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_shipping`
--

CREATE TABLE `ecommerce_shipping` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `loadId` varchar(255) NOT NULL,
  `loadStatus` enum('PENDING','TRANSIT','DELIVERED','CANCELLED') NOT NULL,
  `shipper` varchar(255) NOT NULL,
  `transporter` varchar(255) NOT NULL,
  `goodsType` varchar(255) NOT NULL,
  `weight` float NOT NULL,
  `volume` float NOT NULL,
  `description` varchar(255) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `tax` float DEFAULT NULL,
  `deliveryDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_shipping_address`
--

CREATE TABLE `ecommerce_shipping_address` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `orderId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postalCode` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_user_discount`
--

CREATE TABLE `ecommerce_user_discount` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `discountId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_wishlist`
--

CREATE TABLE `ecommerce_wishlist` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecommerce_wishlist_item`
--

CREATE TABLE `ecommerce_wishlist_item` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `wishlistId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `productId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_blockchain`
--

CREATE TABLE `ecosystem_blockchain` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `version` varchar(191) DEFAULT '0.0.1',
  `productId` varchar(191) NOT NULL,
  `chain` varchar(191) DEFAULT NULL,
  `link` varchar(191) DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_custodial_wallet`
--

CREATE TABLE `ecosystem_custodial_wallet` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `masterWalletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(255) NOT NULL,
  `chain` varchar(255) NOT NULL,
  `network` varchar(255) NOT NULL DEFAULT 'mainnet',
  `status` enum('ACTIVE','INACTIVE','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_market`
--

CREATE TABLE `ecosystem_market` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `pair` varchar(191) NOT NULL,
  `isTrending` tinyint(1) DEFAULT 0,
  `isHot` tinyint(1) DEFAULT 0,
  `metadata` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `currency` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_master_wallet`
--

CREATE TABLE `ecosystem_master_wallet` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `chain` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `balance` double NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `lastIndex` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_private_ledger`
--

CREATE TABLE `ecosystem_private_ledger` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `index` int(11) NOT NULL,
  `currency` varchar(50) NOT NULL,
  `chain` varchar(50) NOT NULL,
  `network` varchar(50) NOT NULL DEFAULT 'mainnet',
  `offchainDifference` double NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_token`
--

CREATE TABLE `ecosystem_token` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `chain` varchar(255) NOT NULL,
  `network` varchar(255) NOT NULL,
  `contract` varchar(255) NOT NULL,
  `contractType` enum('PERMIT','NO_PERMIT','NATIVE') NOT NULL DEFAULT 'PERMIT',
  `type` varchar(255) NOT NULL,
  `decimals` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `precision` int(11) DEFAULT 8,
  `limits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`limits`)),
  `icon` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `fee` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`fee`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ecosystem_utxo`
--

CREATE TABLE `ecosystem_utxo` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `transactionId` varchar(255) NOT NULL,
  `index` int(11) NOT NULL,
  `amount` double NOT NULL,
  `script` varchar(1000) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exchange`
--

CREATE TABLE `exchange` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Internal name identifier for the exchange',
  `title` varchar(191) NOT NULL COMMENT 'Display title of the exchange',
  `status` tinyint(1) DEFAULT 0 COMMENT 'Exchange connection status (active/inactive)',
  `username` varchar(191) DEFAULT NULL COMMENT 'Exchange API username/identifier',
  `licenseStatus` tinyint(1) DEFAULT 0 COMMENT 'Exchange license validation status',
  `version` varchar(191) DEFAULT '0.0.1' COMMENT 'Exchange integration version',
  `productId` varchar(191) DEFAULT NULL COMMENT 'Unique product identifier for the exchange',
  `type` varchar(191) DEFAULT 'spot' COMMENT 'Type of exchange (spot, futures, etc.)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exchange_currency`
--

CREATE TABLE `exchange_currency` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(191) NOT NULL COMMENT 'Currency symbol (e.g., BTC, ETH, USDT)',
  `name` varchar(191) NOT NULL COMMENT 'Full name of the currency (e.g., Bitcoin, Ethereum)',
  `precision` double NOT NULL COMMENT 'Number of decimal places for this currency',
  `price` decimal(30,15) DEFAULT NULL COMMENT 'Current price of the currency',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Currency availability status (active/inactive)',
  `fee` double DEFAULT 0 COMMENT 'Trading fee percentage for this currency'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exchange_market`
--

CREATE TABLE `exchange_market` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `pair` varchar(191) NOT NULL COMMENT 'Quote currency symbol (e.g., USDT, USD)',
  `isTrending` tinyint(1) DEFAULT 0 COMMENT 'Whether this market is currently trending',
  `isHot` tinyint(1) DEFAULT 0 COMMENT 'Whether this market is marked as hot/popular',
  `metadata` text DEFAULT NULL COMMENT 'Additional market configuration and precision settings',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Market availability status (active/inactive)',
  `currency` varchar(191) NOT NULL COMMENT 'Base currency symbol (e.g., BTC, ETH)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exchange_order`
--

CREATE TABLE `exchange_order` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the user who placed this order',
  `referenceId` varchar(191) DEFAULT NULL COMMENT 'External reference ID from exchange',
  `status` enum('OPEN','CLOSED','CANCELED','EXPIRED','REJECTED') NOT NULL COMMENT 'Current status of the exchange order',
  `symbol` varchar(191) NOT NULL COMMENT 'Trading symbol/pair for this order',
  `type` enum('MARKET','LIMIT') NOT NULL COMMENT 'Type of order (market or limit)',
  `timeInForce` enum('GTC','IOC','FOK','PO') NOT NULL COMMENT 'Time in force policy (GTC=Good Till Canceled, IOC=Immediate or Cancel, etc.)',
  `side` enum('BUY','SELL') NOT NULL COMMENT 'Order side - buy or sell',
  `price` double NOT NULL COMMENT 'Order price per unit',
  `average` double DEFAULT NULL COMMENT 'Average execution price for filled portions',
  `amount` double NOT NULL COMMENT 'Total amount/quantity to trade',
  `filled` double NOT NULL COMMENT 'Amount that has been filled/executed',
  `remaining` double NOT NULL COMMENT 'Amount remaining to be filled',
  `cost` double NOT NULL COMMENT 'Total cost of the order (price × filled amount)',
  `trades` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Array of individual trades that make up this order' CHECK (json_valid(`trades`)),
  `fee` double NOT NULL COMMENT 'Transaction fee amount',
  `feeCurrency` varchar(191) NOT NULL COMMENT 'Currency in which the fee is charged',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exchange_watchlist`
--

CREATE TABLE `exchange_watchlist` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the user who added this symbol to watchlist',
  `symbol` varchar(191) NOT NULL COMMENT 'Trading symbol/pair being watched'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `extension`
--

CREATE TABLE `extension` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `productId` varchar(191) NOT NULL COMMENT 'Unique product identifier for the extension',
  `name` varchar(191) NOT NULL COMMENT 'Internal name identifier for the extension',
  `title` varchar(191) DEFAULT NULL COMMENT 'Display title of the extension',
  `description` text DEFAULT NULL COMMENT 'Description of the extension functionality',
  `link` varchar(191) DEFAULT NULL COMMENT 'URL link to extension documentation or website',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Whether the extension is active and available',
  `version` varchar(191) DEFAULT '0.0.1' COMMENT 'Version number of the extension',
  `image` varchar(1000) DEFAULT NULL COMMENT 'URL path to the extension''s icon or logo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE `faq` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `faqCategoryId` varchar(191) NOT NULL,
  `question` longtext NOT NULL,
  `answer` longtext NOT NULL,
  `videoUrl` longtext DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `category` varchar(191) NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `order` int(11) NOT NULL DEFAULT 0,
  `pagePath` varchar(191) NOT NULL,
  `relatedFaqIds` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`relatedFaqIds`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `views` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_category`
--

CREATE TABLE `faq_category` (
  `id` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_feedbacks`
--

CREATE TABLE `faq_feedbacks` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `faqId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `isHelpful` tinyint(1) NOT NULL,
  `comment` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_questions`
--

CREATE TABLE `faq_questions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `question` text NOT NULL,
  `answer` text DEFAULT NULL,
  `status` enum('PENDING','ANSWERED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_searches`
--

CREATE TABLE `faq_searches` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `query` text NOT NULL,
  `resultCount` int(11) NOT NULL DEFAULT 0,
  `category` varchar(191) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_views`
--

CREATE TABLE `faq_views` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `faqId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sessionId` varchar(191) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_account`
--

CREATE TABLE `forex_account` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `accountId` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `broker` varchar(191) DEFAULT NULL,
  `mt` int(11) DEFAULT NULL,
  `balance` double DEFAULT 0,
  `leverage` int(11) DEFAULT 1,
  `type` enum('DEMO','LIVE') NOT NULL DEFAULT 'DEMO',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `dailyWithdrawLimit` double DEFAULT 5000,
  `monthlyWithdrawLimit` double DEFAULT 50000,
  `dailyWithdrawn` double DEFAULT 0,
  `monthlyWithdrawn` double DEFAULT 0,
  `lastWithdrawReset` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_account_signal`
--

CREATE TABLE `forex_account_signal` (
  `forexAccountId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `forexSignalId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_currency`
--

CREATE TABLE `forex_currency` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(191) NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_duration`
--

CREATE TABLE `forex_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `duration` int(11) NOT NULL,
  `timeframe` enum('HOUR','DAY','WEEK','MONTH') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_investment`
--

CREATE TABLE `forex_investment` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `result` enum('WIN','LOSS','DRAW') DEFAULT NULL,
  `status` enum('ACTIVE','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'ACTIVE',
  `endDate` datetime(3) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `metadata` text DEFAULT NULL,
  `termsAcceptedAt` datetime(3) DEFAULT NULL,
  `termsVersion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_plan`
--

CREATE TABLE `forex_plan` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `minProfit` double NOT NULL,
  `maxProfit` double NOT NULL,
  `minAmount` double DEFAULT 0,
  `maxAmount` double DEFAULT NULL,
  `profitPercentage` double NOT NULL DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `defaultProfit` int(11) NOT NULL DEFAULT 0,
  `defaultResult` enum('WIN','LOSS','DRAW') NOT NULL,
  `trending` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `currency` varchar(191) NOT NULL,
  `walletType` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_plan_duration`
--

CREATE TABLE `forex_plan_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forex_signal`
--

CREATE TABLE `forex_signal` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(191) NOT NULL,
  `image` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `futures_market`
--

CREATE TABLE `futures_market` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(191) NOT NULL,
  `pair` varchar(191) NOT NULL,
  `isTrending` tinyint(1) DEFAULT 0,
  `isHot` tinyint(1) DEFAULT 0,
  `metadata` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_page_config`
--

CREATE TABLE `home_page_config` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `sections` longtext NOT NULL DEFAULT '{}',
  `content` longtext NOT NULL DEFAULT '{}',
  `images` longtext NOT NULL DEFAULT '{}',
  `isActive` tinyint(1) NOT NULL DEFAULT 0,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_admin_activity`
--

CREATE TABLE `ico_admin_activity` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(50) NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringName` varchar(191) NOT NULL,
  `adminId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_allocation`
--

CREATE TABLE `ico_allocation` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `percentage` double NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('PENDING','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_blockchain`
--

CREATE TABLE `ico_blockchain` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_contribution`
--

CREATE TABLE `ico_contribution` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `phaseId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL,
  `status` enum('PENDING','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_launch_plan`
--

CREATE TABLE `ico_launch_plan` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `currency` varchar(10) NOT NULL,
  `walletType` varchar(191) NOT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`features`)),
  `recommended` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_phase`
--

CREATE TABLE `ico_phase` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `startDate` datetime(3) NOT NULL,
  `endDate` datetime(3) NOT NULL,
  `price` double NOT NULL,
  `status` enum('PENDING','ACTIVE','COMPLETED','REJECTED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `minPurchase` double NOT NULL DEFAULT 0,
  `maxPurchase` double NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_phase_allocation`
--

CREATE TABLE `ico_phase_allocation` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `allocationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `phaseId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `percentage` double NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_project`
--

CREATE TABLE `ico_project` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `website` varchar(191) NOT NULL,
  `whitepaper` longtext NOT NULL,
  `image` varchar(191) NOT NULL,
  `status` enum('PENDING','ACTIVE','COMPLETED','REJECTED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_roadmap_item`
--

CREATE TABLE `ico_roadmap_item` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `date` varchar(50) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_team_member`
--

CREATE TABLE `ico_team_member` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `role` varchar(100) NOT NULL,
  `bio` text NOT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `linkedin` varchar(191) DEFAULT NULL,
  `twitter` varchar(191) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `github` varchar(191) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token`
--

CREATE TABLE `ico_token` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `projectId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `chain` varchar(191) NOT NULL,
  `currency` varchar(191) NOT NULL,
  `purchaseCurrency` varchar(191) NOT NULL DEFAULT 'ETH',
  `purchaseWalletType` enum('FIAT','SPOT','ECO') NOT NULL DEFAULT 'SPOT',
  `address` varchar(191) NOT NULL,
  `totalSupply` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(191) NOT NULL,
  `status` enum('PENDING','ACTIVE','COMPLETED','REJECTED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_detail`
--

CREATE TABLE `ico_token_detail` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenType` varchar(50) NOT NULL,
  `totalSupply` double NOT NULL,
  `tokensForSale` double NOT NULL,
  `salePercentage` double NOT NULL,
  `blockchain` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `useOfFunds` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`useOfFunds`)),
  `links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`links`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_offering`
--

CREATE TABLE `ico_token_offering` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `icon` varchar(191) NOT NULL,
  `status` enum('ACTIVE','SUCCESS','FAILED','UPCOMING','PENDING','REJECTED') NOT NULL,
  `tokenPrice` double NOT NULL,
  `targetAmount` double NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `participants` int(11) NOT NULL,
  `currentPrice` double DEFAULT NULL,
  `priceChange` double DEFAULT NULL,
  `submittedAt` datetime DEFAULT NULL,
  `approvedAt` datetime DEFAULT NULL,
  `rejectedAt` datetime DEFAULT NULL,
  `reviewNotes` varchar(191) DEFAULT NULL,
  `isPaused` tinyint(1) NOT NULL DEFAULT 0,
  `isFlagged` tinyint(1) NOT NULL DEFAULT 0,
  `featured` tinyint(1) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `purchaseWalletCurrency` varchar(10) NOT NULL,
  `purchaseWalletType` varchar(191) NOT NULL,
  `typeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_offering_phase`
--

CREATE TABLE `ico_token_offering_phase` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `tokenPrice` double NOT NULL,
  `allocation` double NOT NULL,
  `remaining` double NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_offering_update`
--

CREATE TABLE `ico_token_offering_update` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(191) NOT NULL,
  `content` text NOT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_type`
--

CREATE TABLE `ico_token_type` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_token_vesting`
--

CREATE TABLE `ico_token_vesting` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `totalAmount` double NOT NULL,
  `releasedAmount` double NOT NULL DEFAULT 0,
  `vestingType` enum('LINEAR','CLIFF','MILESTONE') NOT NULL DEFAULT 'LINEAR',
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `cliffDuration` int(11) DEFAULT NULL COMMENT 'Cliff duration in days',
  `releaseSchedule` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON array of milestone releases [{date, percentage, amount}]' CHECK (json_valid(`releaseSchedule`)),
  `status` enum('ACTIVE','COMPLETED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ico_transaction`
--

CREATE TABLE `ico_transaction` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offeringId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL,
  `price` double NOT NULL,
  `status` enum('PENDING','VERIFICATION','RELEASED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `walletAddress` varchar(191) DEFAULT NULL,
  `releaseUrl` varchar(191) NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investment`
--

CREATE TABLE `investment` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL COMMENT 'Amount invested by the user',
  `profit` double DEFAULT NULL COMMENT 'Profit earned from this investment (if completed)',
  `result` enum('WIN','LOSS','DRAW') DEFAULT NULL COMMENT 'Final result of the investment (WIN, LOSS, or DRAW)',
  `status` enum('ACTIVE','COMPLETED','CANCELLED','REJECTED') NOT NULL DEFAULT 'ACTIVE' COMMENT 'Current status of the investment',
  `endDate` datetime(3) DEFAULT NULL COMMENT 'Date when the investment period ends',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investment_duration`
--

CREATE TABLE `investment_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'Duration value (number of timeframe units)',
  `timeframe` enum('HOUR','DAY','WEEK','MONTH') NOT NULL COMMENT 'Time unit for the duration (HOUR, DAY, WEEK, MONTH)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investment_plan`
--

CREATE TABLE `investment_plan` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Unique name identifier for the investment plan',
  `title` varchar(191) NOT NULL COMMENT 'Display title of the investment plan shown to users',
  `image` varchar(191) DEFAULT NULL COMMENT 'URL path to the plan''s image/logo',
  `description` text NOT NULL COMMENT 'Detailed description of the investment plan',
  `currency` varchar(191) NOT NULL COMMENT 'Currency code that this plan accepts for investment',
  `minAmount` double NOT NULL COMMENT 'Minimum amount of investment required for this plan',
  `maxAmount` double NOT NULL COMMENT 'Maximum amount of investment allowed for this plan',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Indicates if this investment plan is active or inactive',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `invested` int(11) NOT NULL DEFAULT 0 COMMENT 'Total amount of money invested in this plan',
  `profitPercentage` double NOT NULL DEFAULT 0 COMMENT 'Expected profit percentage for this plan',
  `minProfit` double NOT NULL COMMENT 'Minimum profit amount for this plan',
  `maxProfit` double NOT NULL COMMENT 'Maximum profit amount for this plan',
  `defaultProfit` int(11) NOT NULL DEFAULT 0 COMMENT 'Default profit amount for this plan',
  `defaultResult` enum('WIN','LOSS','DRAW') NOT NULL COMMENT 'Default outcome for this plan (WIN, LOSS, DRAW)',
  `trending` tinyint(1) DEFAULT 0 COMMENT 'Indicates if this plan is currently trending or popular',
  `walletType` varchar(191) NOT NULL COMMENT 'Type of wallet (e.g., ''crypto'', ''fiat'') that this plan uses'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investment_plan_duration`
--

CREATE TABLE `investment_plan_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `planId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('UNPAID','PAID','CANCELLED') NOT NULL,
  `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `senderId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `receiverId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dueDate` datetime(3) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_application`
--

CREATE TABLE `kyc_application` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `levelId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('PENDING','APPROVED','REJECTED','ADDITIONAL_INFO_REQUIRED') NOT NULL DEFAULT 'PENDING' COMMENT 'Current status of the KYC application review process',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'KYC application data including documents and personal information' CHECK (json_valid(`data`)),
  `adminNotes` text DEFAULT NULL COMMENT 'Notes added by admin during KYC review process',
  `reviewedAt` datetime DEFAULT NULL COMMENT 'Date and time when the application was reviewed by admin',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_level`
--

CREATE TABLE `kyc_level` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Name of the KYC level (e.g., ''Basic'', ''Intermediate'', ''Advanced'')',
  `description` text DEFAULT NULL COMMENT 'Detailed description of the KYC level requirements',
  `level` int(11) NOT NULL COMMENT 'Numeric level indicating the verification tier (1, 2, 3, etc.)',
  `fields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Required fields and documents for this KYC level' CHECK (json_valid(`fields`)),
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Features and benefits unlocked at this KYC level' CHECK (json_valid(`features`)),
  `status` enum('ACTIVE','DRAFT','INACTIVE') NOT NULL DEFAULT 'ACTIVE' COMMENT 'Current status of this KYC level configuration',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `serviceId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_verification_result`
--

CREATE TABLE `kyc_verification_result` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `applicationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `serviceId` varchar(191) NOT NULL,
  `status` enum('VERIFIED','FAILED','PENDING','NOT_STARTED') NOT NULL COMMENT 'Status of the verification process for this service',
  `score` double DEFAULT NULL COMMENT 'Verification confidence score provided by the service',
  `checks` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Detailed verification checks and their results' CHECK (json_valid(`checks`)),
  `documentVerifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Results of document verification checks' CHECK (json_valid(`documentVerifications`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_verification_service`
--

CREATE TABLE `kyc_verification_service` (
  `id` varchar(255) NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Display name of the verification service provider',
  `description` text NOT NULL COMMENT 'Description of the verification service and its capabilities',
  `type` varchar(50) NOT NULL COMMENT 'Type of verification service (e.g., ''document'', ''identity'', ''address'')',
  `integrationDetails` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Configuration and API details for integrating with the service' CHECK (json_valid(`integrationDetails`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mailwizard_block`
--

CREATE TABLE `mailwizard_block` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `design` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mailwizard_campaign`
--

CREATE TABLE `mailwizard_campaign` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `templateId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `status` enum('PENDING','PAUSED','ACTIVE','STOPPED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `speed` int(11) NOT NULL DEFAULT 1,
  `targets` longtext DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mailwizard_template`
--

CREATE TABLE `mailwizard_template` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `content` longtext NOT NULL,
  `design` longtext NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mlm_binary_node`
--

CREATE TABLE `mlm_binary_node` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `referralId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `parentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `leftChildId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `rightChildId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mlm_referral`
--

CREATE TABLE `mlm_referral` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `referrerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `referredId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('PENDING','ACTIVE','REJECTED') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mlm_referral_condition`
--

CREATE TABLE `mlm_referral_condition` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` varchar(191) NOT NULL,
  `type` enum('DEPOSIT','TRADE','INVESTMENT','BINARY_WIN','AI_INVESTMENT','FOREX_INVESTMENT','ICO_CONTRIBUTION','STAKING','ECOMMERCE_PURCHASE','P2P_TRADE') NOT NULL,
  `reward` double NOT NULL,
  `rewardType` enum('PERCENTAGE','FIXED') NOT NULL,
  `rewardWalletType` enum('FIAT','SPOT','ECO') NOT NULL,
  `rewardCurrency` varchar(191) NOT NULL,
  `rewardChain` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mlm_referral_reward`
--

CREATE TABLE `mlm_referral_reward` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `conditionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `referrerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reward` double NOT NULL,
  `isClaimed` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mlm_unilevel_node`
--

CREATE TABLE `mlm_unilevel_node` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `referralId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `parentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_activity`
--

CREATE TABLE `nft_activity` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('MINT','TRANSFER','SALE','LIST','DELIST','BID','OFFER','BURN') NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `listingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `fromUserId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `toUserId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `price` decimal(36,18) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `blockNumber` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_advanced_orders`
--

CREATE TABLE `nft_advanced_orders` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `orderType` enum('LIMIT_BUY','LIMIT_SELL','STOP_LOSS','TAKE_PROFIT','CONDITIONAL') NOT NULL,
  `triggerPrice` decimal(18,8) NOT NULL,
  `executionPrice` decimal(18,8) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'USDT',
  `status` enum('ACTIVE','TRIGGERED','EXECUTED','CANCELLED','EXPIRED') NOT NULL DEFAULT 'ACTIVE',
  `expiresAt` datetime NOT NULL,
  `triggeredAt` datetime DEFAULT NULL,
  `executedAt` datetime DEFAULT NULL,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `autoRelist` tinyint(1) NOT NULL DEFAULT 0,
  `relisting` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`relisting`)),
  `executionTransactionHash` varchar(255) DEFAULT NULL,
  `failureReason` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_asset`
--

CREATE TABLE `nft_asset` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ownerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `image` varchar(191) NOT NULL,
  `attributes` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `price` double DEFAULT NULL,
  `royalty` float DEFAULT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_auction`
--

CREATE TABLE `nft_auction` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nftAssetId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `startingBid` double NOT NULL,
  `reservePrice` double DEFAULT NULL,
  `currentBidId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('ACTIVE','COMPLETED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_bid`
--

CREATE TABLE `nft_bid` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `listingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `bidderId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `expiresAt` datetime DEFAULT NULL,
  `status` enum('ACTIVE','ACCEPTED','REJECTED','EXPIRED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_bridge_transactions`
--

CREATE TABLE `nft_bridge_transactions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sourceChain` varchar(50) NOT NULL,
  `targetChain` varchar(50) NOT NULL,
  `targetNetwork` varchar(50) NOT NULL DEFAULT 'mainnet',
  `bridgeType` enum('LOCK_MINT','BURN_MINT') NOT NULL DEFAULT 'LOCK_MINT',
  `status` enum('INITIATED','PENDING','CONFIRMED','COMPLETED','FAILED','CANCELLED') NOT NULL DEFAULT 'INITIATED',
  `sourceTransactionHash` varchar(255) DEFAULT NULL,
  `targetTransactionHash` varchar(255) DEFAULT NULL,
  `bridgeTransactionHash` varchar(255) DEFAULT NULL,
  `fees` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `gasEstimate` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `actualGasCost` decimal(18,8) DEFAULT NULL,
  `estimatedCompletion` datetime NOT NULL,
  `completedAt` datetime DEFAULT NULL,
  `failureReason` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_category`
--

CREATE TABLE `nft_category` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_collection`
--

CREATE TABLE `nft_collection` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `creatorId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `chain` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `contractAddress` varchar(255) DEFAULT NULL,
  `network` varchar(255) NOT NULL DEFAULT 'mainnet',
  `standard` enum('ERC721','ERC1155') NOT NULL DEFAULT 'ERC721',
  `totalSupply` int(11) DEFAULT 0,
  `maxSupply` int(11) DEFAULT NULL,
  `mintPrice` decimal(36,18) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'ETH',
  `royaltyPercentage` decimal(5,2) DEFAULT 2.50,
  `royaltyAddress` varchar(255) DEFAULT NULL,
  `categoryId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `bannerImage` varchar(1000) DEFAULT NULL,
  `logoImage` varchar(1000) DEFAULT NULL,
  `featuredImage` varchar(1000) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `discord` varchar(500) DEFAULT NULL,
  `twitter` varchar(500) DEFAULT NULL,
  `telegram` varchar(500) DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT 0,
  `isLazyMinted` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('DRAFT','PENDING','ACTIVE','INACTIVE','SUSPENDED') NOT NULL DEFAULT 'DRAFT',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_creator`
--

CREATE TABLE `nft_creator` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `banner` varchar(1000) DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT 0,
  `verificationTier` enum('BRONZE','SILVER','GOLD','PLATINUM') DEFAULT NULL,
  `totalSales` int(11) NOT NULL DEFAULT 0,
  `totalVolume` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `totalItems` int(11) NOT NULL DEFAULT 0,
  `floorPrice` decimal(36,18) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `profilePublic` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_creator_follows`
--

CREATE TABLE `nft_creator_follows` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `followerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `followingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_favorite`
--

CREATE TABLE `nft_favorite` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_feature_comparisons`
--

CREATE TABLE `nft_feature_comparisons` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `web` tinyint(1) NOT NULL DEFAULT 0,
  `mobile` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_fraction`
--

CREATE TABLE `nft_fraction` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ownerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `totalShares` int(11) NOT NULL,
  `availableShares` int(11) NOT NULL,
  `pricePerShare` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `vaultAddress` varchar(255) DEFAULT NULL,
  `fractionTokenAddress` varchar(255) DEFAULT NULL,
  `fractionTokenSymbol` varchar(10) DEFAULT NULL,
  `minimumBuyout` decimal(36,18) DEFAULT NULL,
  `reservePrice` decimal(36,18) DEFAULT NULL,
  `status` enum('ACTIVE','BUYOUT_INITIATED','BOUGHT_OUT','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `buyoutDeadline` datetime DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_fraction_ownership`
--

CREATE TABLE `nft_fraction_ownership` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `fractionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `shares` int(11) NOT NULL,
  `purchasePrice` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `purchasedAt` datetime NOT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `blockNumber` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_listing`
--

CREATE TABLE `nft_listing` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sellerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('FIXED_PRICE','AUCTION','BUNDLE') NOT NULL DEFAULT 'FIXED_PRICE',
  `price` decimal(36,18) DEFAULT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `reservePrice` decimal(36,18) DEFAULT NULL,
  `buyNowPrice` decimal(36,18) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `status` enum('ACTIVE','SOLD','CANCELLED','EXPIRED') NOT NULL DEFAULT 'ACTIVE',
  `views` int(11) NOT NULL DEFAULT 0,
  `likes` int(11) NOT NULL DEFAULT 0,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_menu_configs`
--

CREATE TABLE `nft_menu_configs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `key` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `href` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `auth` tinyint(1) NOT NULL DEFAULT 0,
  `parentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_mobile_features`
--

CREATE TABLE `nft_mobile_features` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `featureId` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `order` int(11) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_offer`
--

CREATE TABLE `nft_offer` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `listingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `offererId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `expiresAt` datetime DEFAULT NULL,
  `status` enum('ACTIVE','ACCEPTED','REJECTED','EXPIRED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_price_ranges`
--

CREATE TABLE `nft_price_ranges` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `min` decimal(18,8) NOT NULL,
  `max` decimal(18,8) DEFAULT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `order` int(11) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_rental`
--

CREATE TABLE `nft_rental` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ownerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `renterId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pricePerDay` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `minRentalDays` int(11) NOT NULL DEFAULT 1,
  `maxRentalDays` int(11) NOT NULL DEFAULT 30,
  `collateralAmount` decimal(36,18) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `actualReturnDate` datetime DEFAULT NULL,
  `totalCost` decimal(36,18) DEFAULT NULL,
  `collateralPaid` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `collateralReturned` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `status` enum('AVAILABLE','RENTED','COMPLETED','CANCELLED','OVERDUE') NOT NULL DEFAULT 'AVAILABLE',
  `terms` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_review`
--

CREATE TABLE `nft_review` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `creatorId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT 0,
  `helpfulCount` int(11) NOT NULL DEFAULT 0,
  `status` enum('PENDING','APPROVED','REJECTED','HIDDEN') NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_royalty`
--

CREATE TABLE `nft_royalty` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `saleId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `recipientId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `blockNumber` int(11) DEFAULT NULL,
  `status` enum('PENDING','PAID','FAILED') NOT NULL DEFAULT 'PENDING',
  `paidAt` datetime DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_sale`
--

CREATE TABLE `nft_sale` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `listingId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `sellerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `buyerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` decimal(36,18) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'ETH',
  `marketplaceFee` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `royaltyFee` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `totalFee` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `netAmount` decimal(36,18) NOT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `blockNumber` int(11) DEFAULT NULL,
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_sort_options`
--

CREATE TABLE `nft_sort_options` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `field` varchar(50) NOT NULL,
  `order` enum('asc','desc') NOT NULL DEFAULT 'desc',
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_staking`
--

CREATE TABLE `nft_staking` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `stakedAt` datetime NOT NULL,
  `unstakedAt` datetime DEFAULT NULL,
  `rewardsEarned` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `rewardsClaimed` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `lockPeriod` int(11) DEFAULT NULL,
  `lockEndsAt` datetime DEFAULT NULL,
  `multiplier` decimal(10,2) NOT NULL DEFAULT 1.00,
  `status` enum('ACTIVE','UNSTAKED','LOCKED','EXPIRED') NOT NULL DEFAULT 'ACTIVE',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nft_token`
--

CREATE TABLE `nft_token` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `collectionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `animationUrl` varchar(1000) DEFAULT NULL,
  `externalUrl` varchar(1000) DEFAULT NULL,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `metadataUri` varchar(1000) DEFAULT NULL,
  `metadataHash` varchar(255) DEFAULT NULL,
  `ownerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `creatorId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `mintedAt` datetime DEFAULT NULL,
  `isMinted` tinyint(1) NOT NULL DEFAULT 0,
  `isListed` tinyint(1) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `likes` int(11) NOT NULL DEFAULT 0,
  `rarity` enum('COMMON','UNCOMMON','RARE','EPIC','LEGENDARY') DEFAULT NULL,
  `rarityScore` decimal(10,2) DEFAULT NULL,
  `status` enum('DRAFT','MINTED','BURNED') NOT NULL DEFAULT 'DRAFT',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('investment','message','user','alert','system') NOT NULL,
  `message` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `relatedId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `details` text DEFAULT NULL,
  `actions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`actions`)),
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_template`
--

CREATE TABLE `notification_template` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `emailBody` longtext DEFAULT NULL,
  `smsBody` longtext DEFAULT NULL,
  `pushBody` longtext DEFAULT NULL,
  `shortCodes` text DEFAULT NULL,
  `email` tinyint(1) DEFAULT 0,
  `sms` tinyint(1) DEFAULT 0,
  `push` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `one_time_token`
--

CREATE TABLE `one_time_token` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tokenId` varchar(60) NOT NULL,
  `tokenType` enum('RESET') DEFAULT NULL,
  `expiresAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_activity_logs`
--

CREATE TABLE `p2p_activity_logs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `details` text DEFAULT NULL,
  `relatedEntity` varchar(50) DEFAULT NULL,
  `relatedEntityId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_admin_activity`
--

CREATE TABLE `p2p_admin_activity` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(50) NOT NULL,
  `relatedEntityId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `relatedEntityName` varchar(191) NOT NULL,
  `adminId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_commissions`
--

CREATE TABLE `p2p_commissions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `adminId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL,
  `description` text DEFAULT NULL,
  `tradeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `offerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_disputes`
--

CREATE TABLE `p2p_disputes` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tradeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` varchar(50) NOT NULL,
  `reportedById` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `againstId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` text NOT NULL,
  `details` text DEFAULT NULL,
  `filedOn` datetime NOT NULL,
  `status` enum('PENDING','IN_PROGRESS','RESOLVED') NOT NULL DEFAULT 'PENDING',
  `priority` enum('HIGH','MEDIUM','LOW') NOT NULL,
  `resolution` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`resolution`)),
  `resolvedOn` datetime DEFAULT NULL,
  `messages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`messages`)),
  `evidence` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`evidence`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_offers`
--

CREATE TABLE `p2p_offers` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('BUY','SELL') NOT NULL,
  `currency` varchar(50) NOT NULL,
  `walletType` enum('FIAT','SPOT','ECO') NOT NULL,
  `amountConfig` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`amountConfig`)),
  `priceConfig` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`priceConfig`)),
  `tradeSettings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tradeSettings`)),
  `locationSettings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`locationSettings`)),
  `userRequirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`userRequirements`)),
  `status` enum('DRAFT','PENDING_APPROVAL','ACTIVE','PAUSED','COMPLETED','CANCELLED','REJECTED','EXPIRED') NOT NULL DEFAULT 'DRAFT',
  `views` int(11) NOT NULL DEFAULT 0,
  `systemTags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`systemTags`)),
  `adminNotes` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_offer_flags`
--

CREATE TABLE `p2p_offer_flags` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `flaggedById` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `isFlagged` tinyint(1) NOT NULL DEFAULT 1,
  `reason` text DEFAULT NULL,
  `flaggedAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_offer_payment_method`
--

CREATE TABLE `p2p_offer_payment_method` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `offerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `paymentMethodId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_payment_methods`
--

CREATE TABLE `p2p_payment_methods` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `instructions` longtext DEFAULT NULL,
  `processingTime` varchar(50) DEFAULT NULL,
  `fees` varchar(50) DEFAULT NULL,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `popularityRank` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_reviews`
--

CREATE TABLE `p2p_reviews` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reviewerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `revieweeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tradeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `communicationRating` float NOT NULL,
  `speedRating` float NOT NULL,
  `trustRating` float NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p2p_trades`
--

CREATE TABLE `p2p_trades` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `offerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `buyerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sellerId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('BUY','SELL') NOT NULL,
  `currency` varchar(50) NOT NULL,
  `amount` double NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `status` enum('PENDING','PAYMENT_SENT','COMPLETED','CANCELLED','DISPUTED') NOT NULL DEFAULT 'PENDING',
  `paymentMethod` varchar(50) NOT NULL,
  `paymentDetails` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`paymentDetails`)),
  `timeline` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`timeline`)),
  `terms` text DEFAULT NULL,
  `escrowFee` varchar(50) DEFAULT NULL,
  `escrowTime` varchar(50) DEFAULT NULL,
  `paymentConfirmedAt` datetime DEFAULT NULL,
  `paymentReference` varchar(191) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE `page` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'Title of the page displayed to users and in browser tabs',
  `content` longtext NOT NULL DEFAULT '' COMMENT 'Main content/body of the page (HTML or Markdown)',
  `description` text DEFAULT NULL COMMENT 'Brief description of the page content',
  `image` text DEFAULT NULL COMMENT 'URL path to the page''s featured image',
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug for the page (used in the page URL)',
  `status` enum('PUBLISHED','DRAFT') NOT NULL DEFAULT 'DRAFT' COMMENT 'Publication status of the page (PUBLISHED or DRAFT)',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Full path/route for the page in the website structure',
  `order` int(11) NOT NULL DEFAULT 0 COMMENT 'Display order for page sorting and navigation',
  `visits` int(11) NOT NULL DEFAULT 0 COMMENT 'Number of times this page has been visited',
  `isHome` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Indicates if this page is the site''s homepage (only one allowed)',
  `isBuilderPage` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Indicates if this page was created using the page builder',
  `template` varchar(100) DEFAULT NULL COMMENT 'Template name used for this page layout',
  `category` varchar(100) DEFAULT NULL COMMENT 'Category classification for organizing pages',
  `seoTitle` varchar(255) DEFAULT NULL COMMENT 'SEO optimized title for search engines',
  `seoDescription` text DEFAULT NULL COMMENT 'SEO meta description for search engine results',
  `seoKeywords` text DEFAULT NULL COMMENT 'SEO keywords for search engine optimization',
  `ogImage` text DEFAULT NULL COMMENT 'Open Graph image URL for social media sharing',
  `ogTitle` varchar(255) DEFAULT NULL COMMENT 'Open Graph title for social media sharing',
  `ogDescription` text DEFAULT NULL COMMENT 'Open Graph description for social media sharing',
  `settings` longtext DEFAULT NULL COMMENT 'JSON string containing page-level configuration settings',
  `customCss` longtext DEFAULT NULL COMMENT 'Custom CSS styles specific to this page',
  `customJs` longtext DEFAULT NULL COMMENT 'Custom JavaScript code specific to this page',
  `lastModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Username or ID of the last person to modify this page',
  `publishedAt` datetime DEFAULT NULL COMMENT 'Date and time when the page was first published'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_intent`
--

CREATE TABLE `payment_intent` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` double NOT NULL,
  `currency` varchar(255) NOT NULL,
  `tax` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `status` enum('PENDING','COMPLETED','FAILED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `ipnUrl` text NOT NULL,
  `apiKey` text NOT NULL,
  `successUrl` text NOT NULL,
  `failUrl` text NOT NULL,
  `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_intent_product`
--

CREATE TABLE `payment_intent_product` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `paymentIntentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  `currency` varchar(255) NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Unique permission name (e.g., access.users, create.posts)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'Title of the blog post',
  `content` text NOT NULL COMMENT 'Full content/body of the blog post',
  `categoryId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the category this post belongs to',
  `authorId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the author who wrote this post',
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug for the post (used in URLs)',
  `description` longtext DEFAULT NULL COMMENT 'Brief description or excerpt of the post',
  `status` enum('PUBLISHED','DRAFT') NOT NULL DEFAULT 'DRAFT' COMMENT 'Publication status of the post (PUBLISHED or DRAFT)',
  `image` text DEFAULT NULL COMMENT 'URL path to the featured image for the post',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `views` int(11) DEFAULT 0 COMMENT 'Number of times this post has been viewed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

CREATE TABLE `post_tag` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `postId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the blog post',
  `tagId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'ID of the tag associated with the post'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provider_user`
--

CREATE TABLE `provider_user` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `providerUserId` varchar(255) NOT NULL,
  `provider` enum('GOOGLE','WALLET') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Unique name of the role (e.g., Admin, User, Moderator)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `key` varchar(255) NOT NULL,
  `value` longtext DEFAULT NULL COMMENT 'Setting value in JSON format or plain text'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE `slider` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image` varchar(255) NOT NULL COMMENT 'URL path to the slider image',
  `link` varchar(255) DEFAULT NULL COMMENT 'Optional URL that the slider image should link to when clicked',
  `status` tinyint(1) DEFAULT 1 COMMENT 'Whether this slider item is active and should be displayed',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spot_deposit`
--

CREATE TABLE `spot_deposit` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(255) NOT NULL,
  `chain` varchar(255) NOT NULL,
  `trx` varchar(255) NOT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `fee` double NOT NULL DEFAULT 0,
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED','EXPIRED','REJECTED','REFUNDED','FROZEN','PROCESSING','TIMEOUT') NOT NULL DEFAULT 'PENDING',
  `description` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_admin_activities`
--

CREATE TABLE `staking_admin_activities` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `action` enum('create','update','delete','approve','reject','distribute') NOT NULL,
  `type` enum('pool','position','earnings','settings','withdrawal') NOT NULL,
  `relatedId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_admin_earnings`
--

CREATE TABLE `staking_admin_earnings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `isClaimed` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('PLATFORM_FEE','EARLY_WITHDRAWAL_FEE','PERFORMANCE_FEE','OTHER') NOT NULL,
  `currency` varchar(10) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_duration`
--

CREATE TABLE `staking_duration` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `duration` int(11) NOT NULL,
  `interestRate` double NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_earning_records`
--

CREATE TABLE `staking_earning_records` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `positionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `type` enum('REGULAR','BONUS','REFERRAL') NOT NULL DEFAULT 'REGULAR',
  `description` varchar(191) NOT NULL,
  `isClaimed` tinyint(1) NOT NULL DEFAULT 0,
  `claimedAt` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_external_pool_performances`
--

CREATE TABLE `staking_external_pool_performances` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL,
  `apr` float NOT NULL,
  `totalStaked` float NOT NULL,
  `profit` float NOT NULL,
  `notes` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_log`
--

CREATE TABLE `staking_log` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `durationId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` double NOT NULL,
  `status` enum('ACTIVE','RELEASED','COLLECTED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_pool`
--

CREATE TABLE `staking_pool` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `currency` varchar(191) NOT NULL,
  `chain` varchar(191) DEFAULT NULL,
  `type` enum('FIAT','SPOT','ECO') NOT NULL DEFAULT 'SPOT',
  `minStake` double NOT NULL,
  `maxStake` double NOT NULL,
  `status` enum('ACTIVE','INACTIVE','COMPLETED') NOT NULL DEFAULT 'ACTIVE',
  `icon` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_pools`
--

CREATE TABLE `staking_pools` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(50) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `apr` float NOT NULL,
  `lockPeriod` int(11) NOT NULL,
  `minStake` float NOT NULL,
  `maxStake` float DEFAULT NULL,
  `earlyWithdrawalFee` float NOT NULL DEFAULT 0,
  `adminFeePercentage` float NOT NULL DEFAULT 0,
  `status` enum('ACTIVE','INACTIVE','COMING_SOON') NOT NULL DEFAULT 'INACTIVE',
  `isPromoted` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `earningFrequency` enum('DAILY','WEEKLY','MONTHLY','END_OF_TERM') NOT NULL DEFAULT 'DAILY',
  `autoCompound` tinyint(1) NOT NULL DEFAULT 0,
  `externalPoolUrl` varchar(191) DEFAULT NULL,
  `profitSource` text NOT NULL,
  `fundAllocation` text NOT NULL,
  `risks` text NOT NULL,
  `rewards` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `availableToStake` float NOT NULL DEFAULT 0,
  `walletType` enum('FIAT','SPOT','ECO') NOT NULL DEFAULT 'SPOT',
  `walletChain` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staking_positions`
--

CREATE TABLE `staking_positions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `poolId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `status` enum('ACTIVE','COMPLETED','CANCELLED','PENDING_WITHDRAWAL') NOT NULL DEFAULT 'ACTIVE',
  `withdrawalRequested` tinyint(1) NOT NULL DEFAULT 0,
  `withdrawalRequestDate` datetime DEFAULT NULL,
  `adminNotes` text DEFAULT NULL,
  `completedAt` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket`
--

CREATE TABLE `support_ticket` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `subject` varchar(191) NOT NULL COMMENT 'Subject/title of the support ticket',
  `importance` enum('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'LOW' COMMENT 'Priority level of the support ticket',
  `status` enum('PENDING','OPEN','REPLIED','CLOSED') NOT NULL DEFAULT 'PENDING' COMMENT 'Current status of the support ticket',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `agentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `messages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Array of chat messages between user and support agent' CHECK (json_valid(`messages`)),
  `type` enum('LIVE','TICKET') NOT NULL DEFAULT 'TICKET' COMMENT 'Type of support - live chat or ticket system',
  `agentName` varchar(191) DEFAULT NULL COMMENT 'Agent display name for faster lookup',
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Tags for search/filter (string array)' CHECK (json_valid(`tags`)),
  `responseTime` int(11) DEFAULT NULL COMMENT 'Minutes from creation to first agent reply',
  `satisfaction` float DEFAULT NULL COMMENT 'Rating 1-5 from user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Display name of the tag',
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug for the tag (used in URLs)',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('FAILED','DEPOSIT','WITHDRAW','OUTGOING_TRANSFER','INCOMING_TRANSFER','PAYMENT','REFUND','BINARY_ORDER','EXCHANGE_ORDER','INVESTMENT','INVESTMENT_ROI','AI_INVESTMENT','AI_INVESTMENT_ROI','INVOICE','FOREX_DEPOSIT','FOREX_WITHDRAW','FOREX_INVESTMENT','FOREX_INVESTMENT_ROI','ICO_CONTRIBUTION','REFERRAL_REWARD','STAKING','STAKING_REWARD','P2P_OFFER_TRANSFER','P2P_TRADE') NOT NULL COMMENT 'Type of transaction (deposit, withdrawal, transfer, trading, etc.)',
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED','EXPIRED','REJECTED','REFUNDED','FROZEN','PROCESSING','TIMEOUT') NOT NULL DEFAULT 'PENDING' COMMENT 'Current status of the transaction',
  `amount` double NOT NULL COMMENT 'Transaction amount in the wallet''s currency',
  `fee` double DEFAULT 0 COMMENT 'Fee charged for this transaction',
  `description` text DEFAULT NULL COMMENT 'Human-readable description of the transaction',
  `metadata` text DEFAULT NULL COMMENT 'Additional transaction data in JSON format',
  `referenceId` varchar(191) DEFAULT NULL COMMENT 'External reference ID from payment processor or exchange',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `trxId` varchar(191) DEFAULT NULL COMMENT 'Blockchain transaction hash or ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `two_factor`
--

CREATE TABLE `two_factor` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `secret` varchar(255) NOT NULL,
  `type` enum('EMAIL','SMS','APP') NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `recoveryCodes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(255) DEFAULT NULL COMMENT 'User''s email address (unique identifier)',
  `password` varchar(255) DEFAULT NULL COMMENT 'Hashed password for authentication',
  `avatar` varchar(1000) DEFAULT NULL COMMENT 'URL path to user''s profile picture',
  `firstName` varchar(255) DEFAULT NULL COMMENT 'User''s first name',
  `lastName` varchar(255) DEFAULT NULL COMMENT 'User''s last name',
  `emailVerified` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether the user''s email address has been verified',
  `phone` varchar(255) DEFAULT NULL COMMENT 'User''s phone number with country code',
  `roleId` int(11) DEFAULT NULL,
  `profile` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Additional user profile information in JSON format' CHECK (json_valid(`profile`)),
  `lastLogin` datetime DEFAULT NULL COMMENT 'Timestamp of the user''s last successful login',
  `lastFailedLogin` datetime DEFAULT NULL COMMENT 'Timestamp of the user''s last failed login attempt',
  `failedLoginAttempts` int(11) DEFAULT 0 COMMENT 'Number of consecutive failed login attempts',
  `status` enum('ACTIVE','INACTIVE','SUSPENDED','BANNED') DEFAULT 'ACTIVE' COMMENT 'Current status of the user account',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `phoneVerified` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether the user''s phone number has been verified',
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'User notification and preference settings' CHECK (json_valid(`settings`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userblock`
--

CREATE TABLE `userblock` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `adminId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` text NOT NULL COMMENT 'Reason for blocking the user',
  `isTemporary` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Whether this is a temporary or permanent block',
  `duration` int(11) DEFAULT NULL COMMENT 'Block duration in hours (for temporary blocks)',
  `blockedUntil` datetime DEFAULT NULL COMMENT 'Date and time when the block expires',
  `isActive` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Whether this block is currently active',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userdeletion`
--

CREATE TABLE `userdeletion` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` text DEFAULT NULL,
  `deletedBy` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `deletionDate` datetime NOT NULL,
  `userData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`userData`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

CREATE TABLE `wallet` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('FIAT','SPOT','ECO','FUTURES') NOT NULL COMMENT 'Type of wallet (FIAT for fiat currencies, SPOT for spot trading, ECO for ecosystem, FUTURES for futures trading)',
  `currency` varchar(255) NOT NULL COMMENT 'Currency symbol for this wallet (e.g., BTC, USD, ETH)',
  `balance` double NOT NULL DEFAULT 0 COMMENT 'Available balance in this wallet',
  `inOrder` double DEFAULT 0 COMMENT 'Amount currently locked in open orders',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Whether this wallet is active and usable',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Blockchain addresses associated with this wallet' CHECK (json_valid(`address`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_data`
--

CREATE TABLE `wallet_data` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `walletId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `currency` varchar(255) NOT NULL COMMENT 'Currency symbol for this wallet data',
  `chain` varchar(255) NOT NULL COMMENT 'Blockchain network name (e.g., ETH, BSC, TRX)',
  `balance` double NOT NULL DEFAULT 0 COMMENT 'Current balance for this currency on this chain',
  `index` int(11) DEFAULT NULL COMMENT 'Derivation index for HD wallet generation',
  `data` text NOT NULL COMMENT 'Encrypted wallet data (private keys, addresses, etc.)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_pnl`
--

CREATE TABLE `wallet_pnl` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `balances` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Profit and loss balances for different wallet types (FIAT, SPOT, ECO)' CHECK (json_valid(`balances`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_method`
--

CREATE TABLE `withdraw_method` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'Display name of the withdrawal method',
  `processingTime` varchar(255) NOT NULL COMMENT 'Expected processing time for withdrawals (e.g., ''1-3 business days'')',
  `instructions` text NOT NULL COMMENT 'Step-by-step instructions for using this withdrawal method',
  `image` varchar(1000) DEFAULT NULL COMMENT 'URL path to the method''s logo or icon',
  `fixedFee` double NOT NULL DEFAULT 0 COMMENT 'Fixed fee amount charged for withdrawals',
  `percentageFee` double NOT NULL DEFAULT 0 COMMENT 'Percentage fee charged on withdrawal amount',
  `minAmount` double NOT NULL DEFAULT 0 COMMENT 'Minimum withdrawal amount allowed',
  `maxAmount` double NOT NULL DEFAULT 0 COMMENT 'Maximum withdrawal amount allowed',
  `customFields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Custom form fields required for this withdrawal method' CHECK (json_valid(`customFields`)),
  `status` tinyint(1) DEFAULT 1 COMMENT 'Whether this withdrawal method is active and available',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_profit`
--
ALTER TABLE `admin_profit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminProfitTransactionIdForeign` (`transactionId`) USING BTREE;

--
-- Indexes for table `ai_investment`
--
ALTER TABLE `ai_investment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `aiInvestmentIdKey` (`id`) USING BTREE,
  ADD KEY `aiInvestmentUserIdForeign` (`userId`) USING BTREE,
  ADD KEY `aiInvestmentPlanIdForeign` (`planId`) USING BTREE,
  ADD KEY `aiInvestmentDurationIdForeign` (`durationId`) USING BTREE;

--
-- Indexes for table `ai_investment_duration`
--
ALTER TABLE `ai_investment_duration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ai_investment_plan`
--
ALTER TABLE `ai_investment_plan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `aiInvestmentPlanNameKey` (`name`);

--
-- Indexes for table `ai_investment_plan_duration`
--
ALTER TABLE `ai_investment_plan_duration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ai_investment_plan_duration_durationId_planId_unique` (`planId`,`durationId`),
  ADD KEY `aiInvestmentPlanDurationPlanIdForeign` (`planId`) USING BTREE,
  ADD KEY `aiInvestmentPlanDurationDurationIdForeign` (`durationId`) USING BTREE;

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `apiKeyUserIdIdx` (`userId`) USING BTREE;

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `authorUserIdFkey` (`userId`),
  ADD UNIQUE KEY `authorIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `authorUserIdKey` (`userId`) USING BTREE;

--
-- Indexes for table `binary_duration`
--
ALTER TABLE `binary_duration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `binaryDuration_pkey` (`id`),
  ADD KEY `binaryDuration_duration_idx` (`duration`);

--
-- Indexes for table `binary_market`
--
ALTER TABLE `binary_market`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `binaryMarketCurrencyPairKey` (`currency`,`pair`) USING BTREE;

--
-- Indexes for table `binary_order`
--
ALTER TABLE `binary_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `binaryOrderIdKey` (`id`) USING BTREE,
  ADD KEY `binaryOrderUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categorySlugKey` (`slug`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commentsPostIdForeign` (`postId`) USING BTREE,
  ADD KEY `commentsAuthorIdForeign` (`userId`) USING BTREE,
  ADD KEY `commentsUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency_swap`
--
ALTER TABLE `currency_swap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userIdIndex` (`userId`);

--
-- Indexes for table `default_pages`
--
ALTER TABLE `default_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_page_source` (`pageId`,`pageSource`),
  ADD KEY `default_pages_status` (`status`),
  ADD KEY `default_pages_type` (`type`);

--
-- Indexes for table `deposit_gateway`
--
ALTER TABLE `deposit_gateway`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depositGatewayNameKey` (`name`),
  ADD UNIQUE KEY `depositGatewayAliasKey` (`alias`),
  ADD UNIQUE KEY `depositGatewayProductIdKey` (`productId`);

--
-- Indexes for table `deposit_method`
--
ALTER TABLE `deposit_method`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ecommerce_category`
--
ALTER TABLE `ecommerce_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ecommerce_discount`
--
ALTER TABLE `ecommerce_discount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerceDiscountCodeKey` (`code`),
  ADD KEY `ecommerceDiscountProductIdFkey` (`productId`) USING BTREE;

--
-- Indexes for table `ecommerce_order`
--
ALTER TABLE `ecommerce_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerceOrderIdKey` (`id`) USING BTREE,
  ADD KEY `ecommerceOrderUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `ecommerceOrderShippingIdFkey` (`shippingId`) USING BTREE,
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `ecommerce_order_item`
--
ALTER TABLE `ecommerce_order_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerce_order_item_productId_orderId_unique` (`orderId`,`productId`),
  ADD UNIQUE KEY `ecommerceOrderItemOrderIdProductIdKey` (`orderId`,`productId`) USING BTREE,
  ADD KEY `ecommerceOrderItemProductIdFkey` (`productId`) USING BTREE;

--
-- Indexes for table `ecommerce_product`
--
ALTER TABLE `ecommerce_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ecommerceProductCategoryIdFkey` (`categoryId`) USING BTREE;

--
-- Indexes for table `ecommerce_product_variant`
--
ALTER TABLE `ecommerce_product_variant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD UNIQUE KEY `ecommerceProductVariantSkuKey` (`sku`) USING BTREE,
  ADD UNIQUE KEY `sku_2` (`sku`),
  ADD KEY `ecommerceProductVariantProductIdFkey` (`productId`) USING BTREE,
  ADD KEY `ecommerceProductVariantSortOrder` (`sortOrder`) USING BTREE;

--
-- Indexes for table `ecommerce_review`
--
ALTER TABLE `ecommerce_review`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerceReviewProductIdUserIdUnique` (`productId`,`userId`) USING BTREE,
  ADD KEY `ecommerceReviewUserIdFkey` (`userId`) USING BTREE;

--
-- Indexes for table `ecommerce_shipping`
--
ALTER TABLE `ecommerce_shipping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ecommerce_shipping_address`
--
ALTER TABLE `ecommerce_shipping_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `ecommerce_user_discount`
--
ALTER TABLE `ecommerce_user_discount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerceUserDiscountUserIdDiscountIdUnique` (`userId`,`discountId`) USING BTREE,
  ADD KEY `ecommerceUserDiscountDiscountIdFkey` (`discountId`) USING BTREE;

--
-- Indexes for table `ecommerce_wishlist`
--
ALTER TABLE `ecommerce_wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ecommerceWishlistUserIdFkey` (`userId`) USING BTREE;

--
-- Indexes for table `ecommerce_wishlist_item`
--
ALTER TABLE `ecommerce_wishlist_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecommerce_wishlist_item_productId_wishlistId_unique` (`wishlistId`,`productId`),
  ADD UNIQUE KEY `ecommerceWishlistItemWishlistIdProductId` (`wishlistId`,`productId`) USING BTREE,
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `ecosystem_blockchain`
--
ALTER TABLE `ecosystem_blockchain`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecosystemBlockchainNameKey` (`name`),
  ADD UNIQUE KEY `ecosystemBlockchainProductIdKey` (`productId`) USING BTREE;

--
-- Indexes for table `ecosystem_custodial_wallet`
--
ALTER TABLE `ecosystem_custodial_wallet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecosystemCustodialWalletAddressKey` (`address`),
  ADD UNIQUE KEY `ecosystemCustodialWalletIdKey` (`id`) USING BTREE,
  ADD KEY `custodialWalletMasterWalletIdIdx` (`masterWalletId`) USING BTREE;

--
-- Indexes for table `ecosystem_market`
--
ALTER TABLE `ecosystem_market`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecosystemMarketCurrencyPairKey` (`currency`,`pair`) USING BTREE;

--
-- Indexes for table `ecosystem_master_wallet`
--
ALTER TABLE `ecosystem_master_wallet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecosystemMasterWalletIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `ecosystemMasterWalletChainCurrencyKey` (`chain`,`currency`) USING BTREE;

--
-- Indexes for table `ecosystem_private_ledger`
--
ALTER TABLE `ecosystem_private_ledger`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniqueEcosystemPrivateLedger` (`walletId`,`index`,`currency`,`chain`,`network`) USING BTREE;

--
-- Indexes for table `ecosystem_token`
--
ALTER TABLE `ecosystem_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ecosystemTokenContractChainKey` (`contract`,`chain`) USING BTREE;

--
-- Indexes for table `ecosystem_utxo`
--
ALTER TABLE `ecosystem_utxo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ecosystemUtxoWalletIdIdx` (`walletId`) USING BTREE;

--
-- Indexes for table `exchange`
--
ALTER TABLE `exchange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exchangeProductIdKey` (`productId`);

--
-- Indexes for table `exchange_currency`
--
ALTER TABLE `exchange_currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exchangeCurrencyCurrencyKey` (`currency`);

--
-- Indexes for table `exchange_market`
--
ALTER TABLE `exchange_market`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exchangeMarketCurrencyPairKey` (`currency`,`pair`) USING BTREE;

--
-- Indexes for table `exchange_order`
--
ALTER TABLE `exchange_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exchangeOrderIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `exchangeOrderReferenceIdKey` (`referenceId`),
  ADD KEY `exchangeOrderUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `exchange_watchlist`
--
ALTER TABLE `exchange_watchlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exchangeWatchlistUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `extension`
--
ALTER TABLE `extension`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `extensionProductIdKey` (`productId`),
  ADD UNIQUE KEY `extensionNameKey` (`name`);

--
-- Indexes for table `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqCategoryId` (`faqCategoryId`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_category_idx` (`category`),
  ADD KEY `faqs_pagePath_idx` (`pagePath`),
  ADD KEY `faqs_order_idx` (`order`);

--
-- Indexes for table `faq_category`
--
ALTER TABLE `faq_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faq_feedbacks`
--
ALTER TABLE `faq_feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `faq_feedbacks_unique_user_faq` (`userId`,`faqId`),
  ADD KEY `faq_feedbacks_faqId_idx` (`faqId`),
  ADD KEY `faq_feedbacks_userId_idx` (`userId`);

--
-- Indexes for table `faq_questions`
--
ALTER TABLE `faq_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faq_questions_status_idx` (`status`);

--
-- Indexes for table `faq_searches`
--
ALTER TABLE `faq_searches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faq_searches_query_idx` (`query`(768)),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `faq_views`
--
ALTER TABLE `faq_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faq_views_faqId_idx` (`faqId`),
  ADD KEY `faq_views_sessionId_idx` (`sessionId`);

--
-- Indexes for table `forex_account`
--
ALTER TABLE `forex_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forexAccountUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `forexAccountUserIdTypeIdx` (`userId`,`type`) USING BTREE,
  ADD KEY `forexAccountStatusIdx` (`status`) USING BTREE,
  ADD KEY `forexAccountCreatedAtIdx` (`createdAt`) USING BTREE;

--
-- Indexes for table `forex_account_signal`
--
ALTER TABLE `forex_account_signal`
  ADD PRIMARY KEY (`forexAccountId`,`forexSignalId`),
  ADD UNIQUE KEY `forex_account_signal_forexSignalId_forexAccountId_unique` (`forexAccountId`,`forexSignalId`),
  ADD KEY `forexAccountSignalForexSignalIdFkey` (`forexSignalId`) USING BTREE;

--
-- Indexes for table `forex_currency`
--
ALTER TABLE `forex_currency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forex_duration`
--
ALTER TABLE `forex_duration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forex_investment`
--
ALTER TABLE `forex_investment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forexInvestmentIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `forexInvestmentStatusIndex` (`userId`,`planId`,`status`) USING BTREE,
  ADD KEY `forexInvestmentUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `forexInvestmentPlanIdFkey` (`planId`) USING BTREE,
  ADD KEY `forexInvestmentDurationIdFkey` (`durationId`) USING BTREE,
  ADD KEY `forexInvestmentUserIdStatusIdx` (`userId`,`status`) USING BTREE,
  ADD KEY `forexInvestmentCreatedAtIdx` (`createdAt`) USING BTREE,
  ADD KEY `forexInvestmentEndDateIdx` (`endDate`) USING BTREE;

--
-- Indexes for table `forex_plan`
--
ALTER TABLE `forex_plan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forexPlanNameKey` (`name`),
  ADD KEY `forexPlanStatusIdx` (`status`) USING BTREE,
  ADD KEY `forexPlanCurrencyIdx` (`currency`) USING BTREE,
  ADD KEY `forexPlanTrendingIdx` (`trending`) USING BTREE;

--
-- Indexes for table `forex_plan_duration`
--
ALTER TABLE `forex_plan_duration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forex_plan_duration_durationId_planId_unique` (`planId`,`durationId`),
  ADD KEY `idxPlanId` (`planId`) USING BTREE,
  ADD KEY `idxDurationId` (`durationId`) USING BTREE;

--
-- Indexes for table `forex_signal`
--
ALTER TABLE `forex_signal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `futures_market`
--
ALTER TABLE `futures_market`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `futuresMarketCurrencyPairKey` (`currency`,`pair`) USING BTREE;

--
-- Indexes for table `home_page_config`
--
ALTER TABLE `home_page_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `homePageConfigNameIndex` (`name`) USING BTREE,
  ADD KEY `homePageConfigIsActiveIndex` (`isActive`) USING BTREE,
  ADD KEY `homePageConfigIsDefaultIndex` (`isDefault`) USING BTREE,
  ADD KEY `homePageConfigOrderIndex` (`order`) USING BTREE;

--
-- Indexes for table `ico_admin_activity`
--
ALTER TABLE `ico_admin_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offeringId` (`offeringId`),
  ADD KEY `adminId` (`adminId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `ico_allocation`
--
ALTER TABLE `ico_allocation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `icoAllocationTokenIdFkey` (`tokenId`),
  ADD UNIQUE KEY `icoAllocationTokenIdKey` (`tokenId`) USING BTREE;

--
-- Indexes for table `ico_blockchain`
--
ALTER TABLE `ico_blockchain`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ico_contribution`
--
ALTER TABLE `ico_contribution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `icoContributionIdKey` (`id`) USING BTREE,
  ADD KEY `icoContributionUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `icoContributionPhaseIdFkey` (`phaseId`) USING BTREE;

--
-- Indexes for table `ico_launch_plan`
--
ALTER TABLE `ico_launch_plan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ico_phase`
--
ALTER TABLE `ico_phase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `icoPhaseTokenIdFkey` (`tokenId`) USING BTREE;

--
-- Indexes for table `ico_phase_allocation`
--
ALTER TABLE `ico_phase_allocation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `icoPhaseAllocationAllocationIdFkey` (`allocationId`) USING BTREE,
  ADD KEY `icoPhaseAllocationPhaseIdFkey` (`phaseId`) USING BTREE;

--
-- Indexes for table `ico_project`
--
ALTER TABLE `ico_project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `icoProjectIdKey` (`id`) USING BTREE;

--
-- Indexes for table `ico_roadmap_item`
--
ALTER TABLE `ico_roadmap_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offeringId` (`offeringId`);

--
-- Indexes for table `ico_team_member`
--
ALTER TABLE `ico_team_member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offeringId` (`offeringId`);

--
-- Indexes for table `ico_token`
--
ALTER TABLE `ico_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `icoTokenProjectIdFkey` (`projectId`) USING BTREE;

--
-- Indexes for table `ico_token_detail`
--
ALTER TABLE `ico_token_detail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `offeringId` (`offeringId`),
  ADD UNIQUE KEY `icoTokenDetailOfferingIdKey` (`offeringId`),
  ADD UNIQUE KEY `offeringId_2` (`offeringId`),
  ADD UNIQUE KEY `offeringId_3` (`offeringId`),
  ADD UNIQUE KEY `offeringId_4` (`offeringId`),
  ADD UNIQUE KEY `offeringId_5` (`offeringId`),
  ADD UNIQUE KEY `offeringId_6` (`offeringId`),
  ADD UNIQUE KEY `offeringId_7` (`offeringId`),
  ADD UNIQUE KEY `offeringId_8` (`offeringId`),
  ADD UNIQUE KEY `offeringId_9` (`offeringId`),
  ADD UNIQUE KEY `offeringId_10` (`offeringId`),
  ADD UNIQUE KEY `offeringId_11` (`offeringId`),
  ADD UNIQUE KEY `offeringId_12` (`offeringId`),
  ADD UNIQUE KEY `offeringId_13` (`offeringId`),
  ADD UNIQUE KEY `offeringId_14` (`offeringId`),
  ADD UNIQUE KEY `offeringId_15` (`offeringId`),
  ADD UNIQUE KEY `offeringId_16` (`offeringId`),
  ADD UNIQUE KEY `offeringId_17` (`offeringId`),
  ADD UNIQUE KEY `offeringId_18` (`offeringId`),
  ADD UNIQUE KEY `offeringId_19` (`offeringId`),
  ADD UNIQUE KEY `offeringId_20` (`offeringId`),
  ADD UNIQUE KEY `offeringId_21` (`offeringId`),
  ADD UNIQUE KEY `offeringId_22` (`offeringId`),
  ADD UNIQUE KEY `offeringId_23` (`offeringId`),
  ADD UNIQUE KEY `offeringId_24` (`offeringId`),
  ADD UNIQUE KEY `offeringId_25` (`offeringId`),
  ADD UNIQUE KEY `offeringId_26` (`offeringId`),
  ADD UNIQUE KEY `offeringId_27` (`offeringId`),
  ADD UNIQUE KEY `offeringId_28` (`offeringId`),
  ADD UNIQUE KEY `offeringId_29` (`offeringId`),
  ADD UNIQUE KEY `offeringId_30` (`offeringId`),
  ADD UNIQUE KEY `offeringId_31` (`offeringId`),
  ADD UNIQUE KEY `offeringId_32` (`offeringId`),
  ADD UNIQUE KEY `offeringId_33` (`offeringId`),
  ADD UNIQUE KEY `offeringId_34` (`offeringId`),
  ADD UNIQUE KEY `offeringId_35` (`offeringId`),
  ADD UNIQUE KEY `offeringId_36` (`offeringId`),
  ADD UNIQUE KEY `offeringId_37` (`offeringId`),
  ADD UNIQUE KEY `offeringId_38` (`offeringId`),
  ADD UNIQUE KEY `offeringId_39` (`offeringId`),
  ADD UNIQUE KEY `offeringId_40` (`offeringId`),
  ADD UNIQUE KEY `offeringId_41` (`offeringId`),
  ADD UNIQUE KEY `offeringId_42` (`offeringId`),
  ADD UNIQUE KEY `offeringId_43` (`offeringId`),
  ADD UNIQUE KEY `offeringId_44` (`offeringId`),
  ADD UNIQUE KEY `offeringId_45` (`offeringId`),
  ADD UNIQUE KEY `offeringId_46` (`offeringId`),
  ADD UNIQUE KEY `offeringId_47` (`offeringId`),
  ADD UNIQUE KEY `offeringId_48` (`offeringId`),
  ADD UNIQUE KEY `offeringId_49` (`offeringId`),
  ADD UNIQUE KEY `offeringId_50` (`offeringId`),
  ADD UNIQUE KEY `offeringId_51` (`offeringId`),
  ADD UNIQUE KEY `offeringId_52` (`offeringId`),
  ADD UNIQUE KEY `offeringId_53` (`offeringId`),
  ADD UNIQUE KEY `offeringId_54` (`offeringId`),
  ADD UNIQUE KEY `offeringId_55` (`offeringId`),
  ADD UNIQUE KEY `offeringId_56` (`offeringId`),
  ADD UNIQUE KEY `offeringId_57` (`offeringId`),
  ADD UNIQUE KEY `offeringId_58` (`offeringId`),
  ADD UNIQUE KEY `offeringId_59` (`offeringId`),
  ADD UNIQUE KEY `offeringId_60` (`offeringId`),
  ADD UNIQUE KEY `offeringId_61` (`offeringId`),
  ADD UNIQUE KEY `offeringId_62` (`offeringId`);

--
-- Indexes for table `ico_token_offering`
--
ALTER TABLE `ico_token_offering`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `icoTokenOfferingSymbolKey` (`symbol`),
  ADD KEY `userId` (`userId`),
  ADD KEY `planId` (`planId`),
  ADD KEY `typeId` (`typeId`);

--
-- Indexes for table `ico_token_offering_phase`
--
ALTER TABLE `ico_token_offering_phase`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `icoTokenOfferingPhaseOfferingIdNameKey` (`offeringId`,`name`);

--
-- Indexes for table `ico_token_offering_update`
--
ALTER TABLE `ico_token_offering_update`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offeringId` (`offeringId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `ico_token_type`
--
ALTER TABLE `ico_token_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ico_token_vesting`
--
ALTER TABLE `ico_token_vesting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ico_token_vesting_transaction_id` (`transactionId`),
  ADD KEY `ico_token_vesting_user_id` (`userId`),
  ADD KEY `ico_token_vesting_offering_id` (`offeringId`),
  ADD KEY `ico_token_vesting_status` (`status`),
  ADD KEY `ico_token_vesting_start_date_end_date` (`startDate`,`endDate`);

--
-- Indexes for table `ico_transaction`
--
ALTER TABLE `ico_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `icoTransactionOfferingIdUserIdKey` (`offeringId`,`userId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `investment`
--
ALTER TABLE `investment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `investmentIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `investmentUserIdPlanIdStatusUnique` (`userId`,`planId`,`status`) USING BTREE,
  ADD KEY `investmentUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `investmentPlanIdFkey` (`planId`) USING BTREE,
  ADD KEY `investmentDurationIdFkey` (`durationId`) USING BTREE;

--
-- Indexes for table `investment_duration`
--
ALTER TABLE `investment_duration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `investment_plan`
--
ALTER TABLE `investment_plan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `investmentPlanNameKey` (`name`);

--
-- Indexes for table `investment_plan_duration`
--
ALTER TABLE `investment_plan_duration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idxPlanId` (`planId`) USING BTREE,
  ADD KEY `idxDurationId` (`durationId`) USING BTREE;

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoiceSenderIdForeign` (`senderId`) USING BTREE,
  ADD KEY `invoiceReceiverIdForeign` (`receiverId`) USING BTREE,
  ADD KEY `invoiceTransactionIdForeign` (`transactionId`) USING BTREE;

--
-- Indexes for table `kyc_application`
--
ALTER TABLE `kyc_application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `levelId` (`levelId`);

--
-- Indexes for table `kyc_level`
--
ALTER TABLE `kyc_level`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serviceId` (`serviceId`);

--
-- Indexes for table `kyc_verification_result`
--
ALTER TABLE `kyc_verification_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `applicationId` (`applicationId`),
  ADD KEY `serviceId` (`serviceId`);

--
-- Indexes for table `kyc_verification_service`
--
ALTER TABLE `kyc_verification_service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mailwizard_block`
--
ALTER TABLE `mailwizard_block`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mailwizard_campaign`
--
ALTER TABLE `mailwizard_campaign`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mailwizardCampaignTemplateIdForeign` (`templateId`) USING BTREE;

--
-- Indexes for table `mailwizard_template`
--
ALTER TABLE `mailwizard_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mlm_binary_node`
--
ALTER TABLE `mlm_binary_node`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mlmBinaryNodeReferralIdKey` (`referralId`) USING BTREE,
  ADD KEY `mlmBinaryNodeParentIdFkey` (`parentId`) USING BTREE,
  ADD KEY `mlmBinaryNodeLeftChildIdFkey` (`leftChildId`) USING BTREE,
  ADD KEY `mlmBinaryNodeRightChildIdFkey` (`rightChildId`) USING BTREE;

--
-- Indexes for table `mlm_referral`
--
ALTER TABLE `mlm_referral`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mlmReferralReferredIdKey` (`referredId`) USING BTREE,
  ADD UNIQUE KEY `mlmReferralReferrerIdReferredIdKey` (`referrerId`,`referredId`) USING BTREE;

--
-- Indexes for table `mlm_referral_condition`
--
ALTER TABLE `mlm_referral_condition`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `mlmReferralConditionNameKey` (`name`) USING BTREE;

--
-- Indexes for table `mlm_referral_reward`
--
ALTER TABLE `mlm_referral_reward`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mlmReferralRewardConditionIdFkey` (`conditionId`) USING BTREE,
  ADD KEY `mlmReferralRewardReferrerIdFkey` (`referrerId`) USING BTREE;

--
-- Indexes for table `mlm_unilevel_node`
--
ALTER TABLE `mlm_unilevel_node`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mlmUnilevelNodeReferralIdKey` (`referralId`) USING BTREE,
  ADD KEY `mlmUnilevelNodeParentIdFkey` (`parentId`) USING BTREE;

--
-- Indexes for table `nft_activity`
--
ALTER TABLE `nft_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftActivityTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftActivityCollectionIdx` (`collectionId`) USING BTREE,
  ADD KEY `nftActivityTypeIdx` (`type`) USING BTREE,
  ADD KEY `nftActivityFromUserIdx` (`fromUserId`) USING BTREE,
  ADD KEY `nftActivityToUserIdx` (`toUserId`) USING BTREE,
  ADD KEY `nftActivityCreatedAtIdx` (`createdAt`) USING BTREE,
  ADD KEY `listingId` (`listingId`);

--
-- Indexes for table `nft_advanced_orders`
--
ALTER TABLE `nft_advanced_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nft_advanced_orders_token_id` (`tokenId`),
  ADD KEY `nft_advanced_orders_user_id` (`userId`),
  ADD KEY `nft_advanced_orders_order_type` (`orderType`),
  ADD KEY `nft_advanced_orders_status` (`status`),
  ADD KEY `nft_advanced_orders_trigger_price` (`triggerPrice`),
  ADD KEY `nft_advanced_orders_expires_at` (`expiresAt`),
  ADD KEY `nft_advanced_orders_created_at` (`createdAt`);

--
-- Indexes for table `nft_asset`
--
ALTER TABLE `nft_asset`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftAssetNameIndex` (`name`),
  ADD KEY `nftAssetOwnerIdIndex` (`ownerId`),
  ADD KEY `nftAssetCollectionIdIndex` (`collectionId`);

--
-- Indexes for table `nft_auction`
--
ALTER TABLE `nft_auction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftAssetId` (`nftAssetId`);

--
-- Indexes for table `nft_bid`
--
ALTER TABLE `nft_bid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftBidListingIdx` (`listingId`) USING BTREE,
  ADD KEY `nftBidBidderIdx` (`bidderId`) USING BTREE,
  ADD KEY `nftBidStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftBidAmountIdx` (`amount`) USING BTREE,
  ADD KEY `nftBidExpiresAtIdx` (`expiresAt`) USING BTREE;

--
-- Indexes for table `nft_bridge_transactions`
--
ALTER TABLE `nft_bridge_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nft_bridge_transactions_token_id` (`tokenId`),
  ADD KEY `nft_bridge_transactions_user_id` (`userId`),
  ADD KEY `nft_bridge_transactions_status` (`status`),
  ADD KEY `nft_bridge_transactions_source_chain_target_chain` (`sourceChain`,`targetChain`),
  ADD KEY `nft_bridge_transactions_estimated_completion` (`estimatedCompletion`),
  ADD KEY `nft_bridge_transactions_created_at` (`createdAt`);

--
-- Indexes for table `nft_category`
--
ALTER TABLE `nft_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftCategoryNameKey` (`name`),
  ADD UNIQUE KEY `nftCategorySlugKey` (`slug`),
  ADD KEY `nftCategoryStatusIdx` (`status`) USING BTREE;

--
-- Indexes for table `nft_collection`
--
ALTER TABLE `nft_collection`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftCollectionSlugKey` (`slug`) USING BTREE,
  ADD KEY `creatorId` (`creatorId`),
  ADD KEY `nftCollectionCreatorIdx` (`creatorId`) USING BTREE,
  ADD KEY `nftCollectionChainIdx` (`chain`) USING BTREE,
  ADD KEY `nftCollectionStatusIdx` (`status`) USING BTREE,
  ADD KEY `categoryId` (`categoryId`);

--
-- Indexes for table `nft_creator`
--
ALTER TABLE `nft_creator`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftCreatorUserKey` (`userId`),
  ADD KEY `nftCreatorVerifiedIdx` (`isVerified`) USING BTREE,
  ADD KEY `nftCreatorTierIdx` (`verificationTier`) USING BTREE,
  ADD KEY `nftCreatorVolumeIdx` (`totalVolume`) USING BTREE;

--
-- Indexes for table `nft_creator_follows`
--
ALTER TABLE `nft_creator_follows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_creator_follow` (`followerId`,`followingId`),
  ADD KEY `idx_creator_follow_follower` (`followerId`),
  ADD KEY `idx_creator_follow_following` (`followingId`),
  ADD KEY `idx_creator_follow_created` (`createdAt`);

--
-- Indexes for table `nft_favorite`
--
ALTER TABLE `nft_favorite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftFavoriteUserTokenKey` (`userId`,`tokenId`) USING BTREE,
  ADD UNIQUE KEY `nftFavoriteUserCollectionKey` (`userId`,`collectionId`) USING BTREE,
  ADD KEY `nftFavoriteUserIdx` (`userId`) USING BTREE,
  ADD KEY `nftFavoriteTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftFavoriteCollectionIdx` (`collectionId`) USING BTREE;

--
-- Indexes for table `nft_feature_comparisons`
--
ALTER TABLE `nft_feature_comparisons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nft_feature_comparisons_is_active_order` (`isActive`,`order`),
  ADD KEY `nft_feature_comparisons_web` (`web`),
  ADD KEY `nft_feature_comparisons_mobile` (`mobile`);

--
-- Indexes for table `nft_fraction`
--
ALTER TABLE `nft_fraction`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftFractionTokenKey` (`tokenId`),
  ADD KEY `nftFractionOwnerIdx` (`ownerId`) USING BTREE,
  ADD KEY `nftFractionStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftFractionPriceIdx` (`pricePerShare`) USING BTREE,
  ADD KEY `nftFractionBuyoutDeadlineIdx` (`buyoutDeadline`) USING BTREE;

--
-- Indexes for table `nft_fraction_ownership`
--
ALTER TABLE `nft_fraction_ownership`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftFractionOwnershipFractionUserKey` (`fractionId`,`userId`) USING BTREE,
  ADD KEY `nftFractionOwnershipFractionIdx` (`fractionId`) USING BTREE,
  ADD KEY `nftFractionOwnershipUserIdx` (`userId`) USING BTREE,
  ADD KEY `nftFractionOwnershipPurchasedAtIdx` (`purchasedAt`) USING BTREE;

--
-- Indexes for table `nft_listing`
--
ALTER TABLE `nft_listing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftListingTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftListingSellerIdx` (`sellerId`) USING BTREE,
  ADD KEY `nftListingStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftListingTypeIdx` (`type`) USING BTREE,
  ADD KEY `nftListingPriceIdx` (`price`) USING BTREE;

--
-- Indexes for table `nft_menu_configs`
--
ALTER TABLE `nft_menu_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD UNIQUE KEY `key_2` (`key`),
  ADD UNIQUE KEY `key_3` (`key`),
  ADD UNIQUE KEY `key_4` (`key`),
  ADD UNIQUE KEY `key_5` (`key`),
  ADD UNIQUE KEY `key_6` (`key`),
  ADD UNIQUE KEY `key_7` (`key`),
  ADD UNIQUE KEY `key_8` (`key`),
  ADD KEY `nft_menu_configs_is_active_order` (`isActive`,`order`),
  ADD KEY `nft_menu_configs_parent_id` (`parentId`),
  ADD KEY `nft_menu_configs_key` (`key`);

--
-- Indexes for table `nft_mobile_features`
--
ALTER TABLE `nft_mobile_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `featureId` (`featureId`),
  ADD UNIQUE KEY `featureId_2` (`featureId`),
  ADD UNIQUE KEY `featureId_3` (`featureId`),
  ADD UNIQUE KEY `featureId_4` (`featureId`),
  ADD UNIQUE KEY `featureId_5` (`featureId`),
  ADD UNIQUE KEY `featureId_6` (`featureId`),
  ADD UNIQUE KEY `featureId_7` (`featureId`),
  ADD UNIQUE KEY `featureId_8` (`featureId`),
  ADD KEY `nft_mobile_features_is_active_order` (`isActive`,`order`),
  ADD KEY `nft_mobile_features_feature_id` (`featureId`),
  ADD KEY `nft_mobile_features_available` (`available`);

--
-- Indexes for table `nft_offer`
--
ALTER TABLE `nft_offer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftOfferTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftOfferCollectionIdx` (`collectionId`) USING BTREE,
  ADD KEY `nftOfferListingIdx` (`listingId`) USING BTREE,
  ADD KEY `nftOfferOffererIdx` (`offererId`) USING BTREE,
  ADD KEY `nftOfferStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftOfferAmountIdx` (`amount`) USING BTREE,
  ADD KEY `nftOfferExpiresAtIdx` (`expiresAt`) USING BTREE;

--
-- Indexes for table `nft_price_ranges`
--
ALTER TABLE `nft_price_ranges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `value` (`value`),
  ADD UNIQUE KEY `value_2` (`value`),
  ADD UNIQUE KEY `value_3` (`value`),
  ADD UNIQUE KEY `value_4` (`value`),
  ADD UNIQUE KEY `value_5` (`value`),
  ADD UNIQUE KEY `value_6` (`value`),
  ADD UNIQUE KEY `value_7` (`value`),
  ADD UNIQUE KEY `value_8` (`value`),
  ADD KEY `nft_price_ranges_is_active_order` (`isActive`,`order`),
  ADD KEY `nft_price_ranges_currency` (`currency`);

--
-- Indexes for table `nft_rental`
--
ALTER TABLE `nft_rental`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftRentalTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftRentalOwnerIdx` (`ownerId`) USING BTREE,
  ADD KEY `nftRentalRenterIdx` (`renterId`) USING BTREE,
  ADD KEY `nftRentalStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftRentalStartDateIdx` (`startDate`) USING BTREE,
  ADD KEY `nftRentalEndDateIdx` (`endDate`) USING BTREE,
  ADD KEY `nftRentalPriceIdx` (`pricePerDay`) USING BTREE;

--
-- Indexes for table `nft_review`
--
ALTER TABLE `nft_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftReviewUserIdx` (`userId`) USING BTREE,
  ADD KEY `nftReviewTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftReviewCollectionIdx` (`collectionId`) USING BTREE,
  ADD KEY `nftReviewCreatorIdx` (`creatorId`) USING BTREE,
  ADD KEY `nftReviewStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftReviewRatingIdx` (`rating`) USING BTREE,
  ADD KEY `nftReviewVerifiedIdx` (`isVerified`) USING BTREE;

--
-- Indexes for table `nft_royalty`
--
ALTER TABLE `nft_royalty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftRoyaltySaleIdx` (`saleId`) USING BTREE,
  ADD KEY `nftRoyaltyTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftRoyaltyCollectionIdx` (`collectionId`) USING BTREE,
  ADD KEY `nftRoyaltyRecipientIdx` (`recipientId`) USING BTREE,
  ADD KEY `nftRoyaltyStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftRoyaltyCreatedAtIdx` (`createdAt`) USING BTREE;

--
-- Indexes for table `nft_sale`
--
ALTER TABLE `nft_sale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nftSaleTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftSaleListingIdx` (`listingId`) USING BTREE,
  ADD KEY `nftSaleSellerIdx` (`sellerId`) USING BTREE,
  ADD KEY `nftSaleBuyerIdx` (`buyerId`) USING BTREE,
  ADD KEY `nftSaleStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftSalePriceIdx` (`price`) USING BTREE,
  ADD KEY `nftSaleCreatedAtIdx` (`createdAt`) USING BTREE;

--
-- Indexes for table `nft_sort_options`
--
ALTER TABLE `nft_sort_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `value` (`value`),
  ADD UNIQUE KEY `value_2` (`value`),
  ADD UNIQUE KEY `value_3` (`value`),
  ADD UNIQUE KEY `value_4` (`value`),
  ADD UNIQUE KEY `value_5` (`value`),
  ADD UNIQUE KEY `value_6` (`value`),
  ADD UNIQUE KEY `value_7` (`value`),
  ADD UNIQUE KEY `value_8` (`value`),
  ADD KEY `nft_sort_options_is_active_sort_order` (`isActive`,`sortOrder`),
  ADD KEY `nft_sort_options_field` (`field`);

--
-- Indexes for table `nft_staking`
--
ALTER TABLE `nft_staking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftStakingUserTokenKey` (`userId`,`tokenId`) USING BTREE,
  ADD KEY `nftStakingUserIdx` (`userId`) USING BTREE,
  ADD KEY `nftStakingTokenIdx` (`tokenId`) USING BTREE,
  ADD KEY `nftStakingPoolIdx` (`poolId`) USING BTREE,
  ADD KEY `nftStakingStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftStakingStakedAtIdx` (`stakedAt`) USING BTREE,
  ADD KEY `nftStakingLockEndsAtIdx` (`lockEndsAt`) USING BTREE;

--
-- Indexes for table `nft_token`
--
ALTER TABLE `nft_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nftTokenCollectionTokenKey` (`collectionId`,`tokenId`) USING BTREE,
  ADD KEY `nftTokenCollectionIdx` (`collectionId`) USING BTREE,
  ADD KEY `nftTokenOwnerIdx` (`ownerId`) USING BTREE,
  ADD KEY `nftTokenCreatorIdx` (`creatorId`) USING BTREE,
  ADD KEY `nftTokenStatusIdx` (`status`) USING BTREE,
  ADD KEY `nftTokenListedIdx` (`isListed`) USING BTREE;

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId_index` (`userId`),
  ADD KEY `type_index` (`type`),
  ADD KEY `notificationsUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `notification_template`
--
ALTER TABLE `notification_template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `notificationTemplateNameKey` (`name`) USING BTREE;

--
-- Indexes for table `one_time_token`
--
ALTER TABLE `one_time_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokenId` (`tokenId`);

--
-- Indexes for table `p2p_activity_logs`
--
ALTER TABLE `p2p_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `p2p_admin_activity`
--
ALTER TABLE `p2p_admin_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminId` (`adminId`);

--
-- Indexes for table `p2p_commissions`
--
ALTER TABLE `p2p_commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminId` (`adminId`),
  ADD KEY `tradeId` (`tradeId`),
  ADD KEY `offerId` (`offerId`);

--
-- Indexes for table `p2p_disputes`
--
ALTER TABLE `p2p_disputes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tradeId` (`tradeId`),
  ADD KEY `reportedById` (`reportedById`),
  ADD KEY `againstId` (`againstId`);

--
-- Indexes for table `p2p_offers`
--
ALTER TABLE `p2p_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `p2p_offer_flags`
--
ALTER TABLE `p2p_offer_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offerId` (`offerId`),
  ADD KEY `flaggedById` (`flaggedById`);

--
-- Indexes for table `p2p_offer_payment_method`
--
ALTER TABLE `p2p_offer_payment_method`
  ADD PRIMARY KEY (`offerId`,`paymentMethodId`),
  ADD KEY `paymentMethodId` (`paymentMethodId`);

--
-- Indexes for table `p2p_payment_methods`
--
ALTER TABLE `p2p_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `p2p_reviews`
--
ALTER TABLE `p2p_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviewerId` (`reviewerId`),
  ADD KEY `revieweeId` (`revieweeId`),
  ADD KEY `tradeId` (`tradeId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `p2p_trades`
--
ALTER TABLE `p2p_trades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offerId` (`offerId`),
  ADD KEY `buyerId` (`buyerId`),
  ADD KEY `sellerId` (`sellerId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pageSlugKey` (`slug`),
  ADD KEY `pageStatusIndex` (`status`) USING BTREE,
  ADD KEY `pageIsHomeIndex` (`isHome`) USING BTREE,
  ADD KEY `pageIsBuilderIndex` (`isBuilderPage`) USING BTREE,
  ADD KEY `pageOrderIndex` (`order`) USING BTREE,
  ADD KEY `pagePublishedAtIndex` (`publishedAt`) USING BTREE;

--
-- Indexes for table `payment_intent`
--
ALTER TABLE `payment_intent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `walletId` (`walletId`);

--
-- Indexes for table `payment_intent_product`
--
ALTER TABLE `payment_intent_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paymentIntentId` (`paymentIntentId`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `postSlugKey` (`slug`),
  ADD KEY `postsCategoryIdForeign` (`categoryId`) USING BTREE,
  ADD KEY `postsAuthorIdForeign` (`authorId`) USING BTREE;

--
-- Indexes for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `postTagPostIdForeign` (`postId`) USING BTREE,
  ADD KEY `postTagTagIdForeign` (`tagId`) USING BTREE;

--
-- Indexes for table `provider_user`
--
ALTER TABLE `provider_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `providerUserId` (`providerUserId`),
  ADD KEY `ProviderUserUserIdFkey` (`userId`) USING BTREE;

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roleNameKey` (`name`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_permission_permissionId_roleId_unique` (`roleId`,`permissionId`),
  ADD KEY `RolePermissionPermissionIdFkey` (`permissionId`) USING BTREE,
  ADD KEY `RolePermissionRoleIdFkey` (`roleId`) USING BTREE;

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spot_deposit`
--
ALTER TABLE `spot_deposit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trx` (`trx`),
  ADD UNIQUE KEY `trx_2` (`trx`),
  ADD UNIQUE KEY `trx_3` (`trx`),
  ADD UNIQUE KEY `trx_4` (`trx`),
  ADD UNIQUE KEY `trx_5` (`trx`),
  ADD KEY `userId` (`userId`),
  ADD KEY `walletId` (`walletId`);

--
-- Indexes for table `staking_admin_activities`
--
ALTER TABLE `staking_admin_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_admin_activities_action_idx` (`action`),
  ADD KEY `staking_admin_activities_type_idx` (`type`),
  ADD KEY `staking_admin_activities_relatedId_idx` (`relatedId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `staking_admin_earnings`
--
ALTER TABLE `staking_admin_earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_admin_earnings_pool_idx` (`poolId`),
  ADD KEY `staking_admin_earnings_claimed_idx` (`isClaimed`);

--
-- Indexes for table `staking_duration`
--
ALTER TABLE `staking_duration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stakingDurationPoolIdFkey` (`poolId`) USING BTREE;

--
-- Indexes for table `staking_earning_records`
--
ALTER TABLE `staking_earning_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_earning_records_position_idx` (`positionId`),
  ADD KEY `staking_earning_records_type_idx` (`type`),
  ADD KEY `staking_earning_records_claimed_idx` (`isClaimed`),
  ADD KEY `staking_earning_records_position_claimed_idx` (`positionId`,`isClaimed`),
  ADD KEY `staking_earning_records_claimed_at_idx` (`claimedAt`);

--
-- Indexes for table `staking_external_pool_performances`
--
ALTER TABLE `staking_external_pool_performances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_external_pool_performances_pool_idx` (`poolId`),
  ADD KEY `staking_external_pool_performances_date_idx` (`date`);

--
-- Indexes for table `staking_log`
--
ALTER TABLE `staking_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stakingLogIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `uniqueActiveStake` (`userId`,`poolId`,`status`) USING BTREE,
  ADD KEY `stakingLogUserIdFkey` (`userId`) USING BTREE,
  ADD KEY `stakingLogPoolIdFkey` (`poolId`) USING BTREE,
  ADD KEY `durationId` (`durationId`);

--
-- Indexes for table `staking_pool`
--
ALTER TABLE `staking_pool`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stakingPoolIdKey` (`id`) USING BTREE;

--
-- Indexes for table `staking_pools`
--
ALTER TABLE `staking_pools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_pools_token_idx` (`token`),
  ADD KEY `staking_pools_status_idx` (`status`),
  ADD KEY `staking_pools_order_idx` (`order`);

--
-- Indexes for table `staking_positions`
--
ALTER TABLE `staking_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staking_positions_user_idx` (`userId`),
  ADD KEY `staking_positions_pool_idx` (`poolId`),
  ADD KEY `staking_positions_status_idx` (`status`),
  ADD KEY `staking_positions_withdrawal_idx` (`withdrawalRequested`),
  ADD KEY `staking_positions_user_status_idx` (`userId`,`status`),
  ADD KEY `staking_positions_end_date_idx` (`endDate`),
  ADD KEY `staking_positions_created_idx` (`createdAt`);

--
-- Indexes for table `support_ticket`
--
ALTER TABLE `support_ticket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supportTicketIdKey` (`id`) USING BTREE,
  ADD KEY `supportTicketUserIdForeign` (`userId`) USING BTREE,
  ADD KEY `agentId` (`agentId`) USING BTREE,
  ADD KEY `tags_idx` (`tags`(768)) USING BTREE;

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tagSlugKey` (`slug`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactionIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `transactionReferenceIdKey` (`referenceId`),
  ADD KEY `transactionWalletIdForeign` (`walletId`) USING BTREE,
  ADD KEY `transactionUserIdFkey` (`userId`) USING BTREE;

--
-- Indexes for table `two_factor`
--
ALTER TABLE `two_factor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `twoFactorUserIdFkey` (`userId`),
  ADD UNIQUE KEY `twoFactorUserIdKey` (`userId`) USING BTREE,
  ADD KEY `twoFactorUserIdForeign` (`userId`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `UserRoleIdFkey` (`roleId`) USING BTREE;

--
-- Indexes for table `userblock`
--
ALTER TABLE `userblock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userBlock_userId_idx` (`userId`) USING BTREE,
  ADD KEY `userBlock_adminId_idx` (`adminId`) USING BTREE,
  ADD KEY `userBlock_isActive_idx` (`isActive`) USING BTREE;

--
-- Indexes for table `userdeletion`
--
ALTER TABLE `userdeletion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userDeletion_userId_idx` (`userId`) USING BTREE,
  ADD KEY `userDeletion_deletedBy_idx` (`deletedBy`) USING BTREE,
  ADD KEY `userDeletion_deletionDate_idx` (`deletionDate`) USING BTREE;

--
-- Indexes for table `wallet`
--
ALTER TABLE `wallet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `walletIdKey` (`id`) USING BTREE,
  ADD UNIQUE KEY `walletUserIdCurrencyTypeKey` (`userId`,`currency`,`type`) USING BTREE;

--
-- Indexes for table `wallet_data`
--
ALTER TABLE `wallet_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `walletDataWalletIdCurrencyChainKey` (`walletId`,`currency`,`chain`) USING BTREE;

--
-- Indexes for table `wallet_pnl`
--
ALTER TABLE `wallet_pnl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `withdraw_method`
--
ALTER TABLE `withdraw_method`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notification_template`
--
ALTER TABLE `notification_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_profit`
--
ALTER TABLE `admin_profit`
  ADD CONSTRAINT `admin_profit_ibfk_1` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ai_investment`
--
ALTER TABLE `ai_investment`
  ADD CONSTRAINT `ai_investment_ibfk_43169` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ai_investment_ibfk_43170` FOREIGN KEY (`planId`) REFERENCES `ai_investment_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ai_investment_ibfk_43171` FOREIGN KEY (`durationId`) REFERENCES `ai_investment_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ai_investment_plan_duration`
--
ALTER TABLE `ai_investment_plan_duration`
  ADD CONSTRAINT `ai_investment_plan_duration_ibfk_1717` FOREIGN KEY (`planId`) REFERENCES `ai_investment_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ai_investment_plan_duration_ibfk_1718` FOREIGN KEY (`durationId`) REFERENCES `ai_investment_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `api_key`
--
ALTER TABLE `api_key`
  ADD CONSTRAINT `api_key_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `author`
--
ALTER TABLE `author`
  ADD CONSTRAINT `author_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `binary_order`
--
ALTER TABLE `binary_order`
  ADD CONSTRAINT `binary_order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_4847` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_4848` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `currency_swap`
--
ALTER TABLE `currency_swap`
  ADD CONSTRAINT `currency_swap_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_discount`
--
ALTER TABLE `ecommerce_discount`
  ADD CONSTRAINT `ecommerce_discount_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_order`
--
ALTER TABLE `ecommerce_order`
  ADD CONSTRAINT `ecommerce_order_ibfk_39596` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_order_ibfk_39597` FOREIGN KEY (`shippingId`) REFERENCES `ecommerce_shipping` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_order_ibfk_39598` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_order_item`
--
ALTER TABLE `ecommerce_order_item`
  ADD CONSTRAINT `ecommerce_order_item_ibfk_1123` FOREIGN KEY (`orderId`) REFERENCES `ecommerce_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_order_item_ibfk_1124` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_product`
--
ALTER TABLE `ecommerce_product`
  ADD CONSTRAINT `ecommerce_product_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `ecommerce_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_product_variant`
--
ALTER TABLE `ecommerce_product_variant`
  ADD CONSTRAINT `ecommerce_product_variant_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_review`
--
ALTER TABLE `ecommerce_review`
  ADD CONSTRAINT `ecommerce_review_ibfk_15193` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_review_ibfk_15194` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_shipping_address`
--
ALTER TABLE `ecommerce_shipping_address`
  ADD CONSTRAINT `ecommerce_shipping_address_ibfk_939` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_shipping_address_ibfk_940` FOREIGN KEY (`orderId`) REFERENCES `ecommerce_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_user_discount`
--
ALTER TABLE `ecommerce_user_discount`
  ADD CONSTRAINT `ecommerce_user_discount_ibfk_22435` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_user_discount_ibfk_22436` FOREIGN KEY (`discountId`) REFERENCES `ecommerce_discount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_wishlist`
--
ALTER TABLE `ecommerce_wishlist`
  ADD CONSTRAINT `ecommerce_wishlist_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecommerce_wishlist_item`
--
ALTER TABLE `ecommerce_wishlist_item`
  ADD CONSTRAINT `ecommerce_wishlist_item_ibfk_16357` FOREIGN KEY (`wishlistId`) REFERENCES `ecommerce_wishlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ecommerce_wishlist_item_ibfk_16358` FOREIGN KEY (`productId`) REFERENCES `ecommerce_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecosystem_custodial_wallet`
--
ALTER TABLE `ecosystem_custodial_wallet`
  ADD CONSTRAINT `ecosystem_custodial_wallet_ibfk_1` FOREIGN KEY (`masterWalletId`) REFERENCES `ecosystem_master_wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecosystem_private_ledger`
--
ALTER TABLE `ecosystem_private_ledger`
  ADD CONSTRAINT `ecosystem_private_ledger_ibfk_1` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecosystem_utxo`
--
ALTER TABLE `ecosystem_utxo`
  ADD CONSTRAINT `ecosystem_utxo_ibfk_1` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exchange_order`
--
ALTER TABLE `exchange_order`
  ADD CONSTRAINT `exchange_order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exchange_watchlist`
--
ALTER TABLE `exchange_watchlist`
  ADD CONSTRAINT `exchange_watchlist_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faq`
--
ALTER TABLE `faq`
  ADD CONSTRAINT `faq_ibfk_1` FOREIGN KEY (`faqCategoryId`) REFERENCES `faq_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faq_feedbacks`
--
ALTER TABLE `faq_feedbacks`
  ADD CONSTRAINT `faq_feedbacks_ibfk_5501` FOREIGN KEY (`faqId`) REFERENCES `faqs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faq_feedbacks_ibfk_5502` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faq_searches`
--
ALTER TABLE `faq_searches`
  ADD CONSTRAINT `faq_searches_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faq_views`
--
ALTER TABLE `faq_views`
  ADD CONSTRAINT `faq_views_ibfk_1` FOREIGN KEY (`faqId`) REFERENCES `faqs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forex_account`
--
ALTER TABLE `forex_account`
  ADD CONSTRAINT `forex_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forex_account_signal`
--
ALTER TABLE `forex_account_signal`
  ADD CONSTRAINT `forex_account_signal_ibfk_1` FOREIGN KEY (`forexAccountId`) REFERENCES `forex_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forex_account_signal_ibfk_2` FOREIGN KEY (`forexSignalId`) REFERENCES `forex_signal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forex_investment`
--
ALTER TABLE `forex_investment`
  ADD CONSTRAINT `forex_investment_ibfk_38488` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forex_investment_ibfk_38489` FOREIGN KEY (`planId`) REFERENCES `forex_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forex_investment_ibfk_38490` FOREIGN KEY (`durationId`) REFERENCES `forex_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forex_plan_duration`
--
ALTER TABLE `forex_plan_duration`
  ADD CONSTRAINT `forex_plan_duration_ibfk_17961` FOREIGN KEY (`planId`) REFERENCES `forex_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forex_plan_duration_ibfk_17962` FOREIGN KEY (`durationId`) REFERENCES `forex_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_admin_activity`
--
ALTER TABLE `ico_admin_activity`
  ADD CONSTRAINT `ico_admin_activity_ibfk_9000` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_admin_activity_ibfk_9001` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_admin_activity_ibfk_9002` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_allocation`
--
ALTER TABLE `ico_allocation`
  ADD CONSTRAINT `ico_allocation_ibfk_1` FOREIGN KEY (`tokenId`) REFERENCES `ico_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_contribution`
--
ALTER TABLE `ico_contribution`
  ADD CONSTRAINT `ico_contribution_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_contribution_ibfk_6` FOREIGN KEY (`phaseId`) REFERENCES `ico_phase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_phase`
--
ALTER TABLE `ico_phase`
  ADD CONSTRAINT `ico_phase_ibfk_1` FOREIGN KEY (`tokenId`) REFERENCES `ico_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_phase_allocation`
--
ALTER TABLE `ico_phase_allocation`
  ADD CONSTRAINT `ico_phase_allocation_ibfk_5` FOREIGN KEY (`allocationId`) REFERENCES `ico_allocation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_phase_allocation_ibfk_6` FOREIGN KEY (`phaseId`) REFERENCES `ico_phase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_roadmap_item`
--
ALTER TABLE `ico_roadmap_item`
  ADD CONSTRAINT `ico_roadmap_item_ibfk_1` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_team_member`
--
ALTER TABLE `ico_team_member`
  ADD CONSTRAINT `ico_team_member_ibfk_1` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token`
--
ALTER TABLE `ico_token`
  ADD CONSTRAINT `ico_token_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `ico_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token_detail`
--
ALTER TABLE `ico_token_detail`
  ADD CONSTRAINT `ico_token_detail_ibfk_1` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token_offering`
--
ALTER TABLE `ico_token_offering`
  ADD CONSTRAINT `ico_token_offering_ibfk_9887` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_token_offering_ibfk_9888` FOREIGN KEY (`planId`) REFERENCES `ico_launch_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_token_offering_ibfk_9889` FOREIGN KEY (`typeId`) REFERENCES `ico_token_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token_offering_phase`
--
ALTER TABLE `ico_token_offering_phase`
  ADD CONSTRAINT `ico_token_offering_phase_ibfk_1` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token_offering_update`
--
ALTER TABLE `ico_token_offering_update`
  ADD CONSTRAINT `ico_token_offering_update_ibfk_3963` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_token_offering_update_ibfk_3964` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ico_token_vesting`
--
ALTER TABLE `ico_token_vesting`
  ADD CONSTRAINT `ico_token_vesting_ibfk_31` FOREIGN KEY (`transactionId`) REFERENCES `ico_transaction` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ico_token_vesting_ibfk_32` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ico_token_vesting_ibfk_33` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ico_transaction`
--
ALTER TABLE `ico_transaction`
  ADD CONSTRAINT `ico_transaction_ibfk_1489` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ico_transaction_ibfk_1490` FOREIGN KEY (`offeringId`) REFERENCES `ico_token_offering` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `investment`
--
ALTER TABLE `investment`
  ADD CONSTRAINT `investment_ibfk_40452` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `investment_ibfk_40453` FOREIGN KEY (`planId`) REFERENCES `investment_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `investment_ibfk_40454` FOREIGN KEY (`durationId`) REFERENCES `investment_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `investment_plan_duration`
--
ALTER TABLE `investment_plan_duration`
  ADD CONSTRAINT `investment_plan_duration_ibfk_15363` FOREIGN KEY (`planId`) REFERENCES `investment_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `investment_plan_duration_ibfk_15364` FOREIGN KEY (`durationId`) REFERENCES `investment_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_5064` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_5065` FOREIGN KEY (`senderId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_5066` FOREIGN KEY (`receiverId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kyc_application`
--
ALTER TABLE `kyc_application`
  ADD CONSTRAINT `kyc_application_ibfk_4277` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kyc_application_ibfk_4278` FOREIGN KEY (`levelId`) REFERENCES `kyc_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kyc_level`
--
ALTER TABLE `kyc_level`
  ADD CONSTRAINT `kyc_level_ibfk_1` FOREIGN KEY (`serviceId`) REFERENCES `kyc_verification_service` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `kyc_verification_result`
--
ALTER TABLE `kyc_verification_result`
  ADD CONSTRAINT `kyc_verification_result_ibfk_4205` FOREIGN KEY (`applicationId`) REFERENCES `kyc_application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kyc_verification_result_ibfk_4206` FOREIGN KEY (`serviceId`) REFERENCES `kyc_verification_service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mailwizard_campaign`
--
ALTER TABLE `mailwizard_campaign`
  ADD CONSTRAINT `mailwizard_campaign_ibfk_1` FOREIGN KEY (`templateId`) REFERENCES `mailwizard_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlm_binary_node`
--
ALTER TABLE `mlm_binary_node`
  ADD CONSTRAINT `mlm_binary_node_ibfk_8804` FOREIGN KEY (`referralId`) REFERENCES `mlm_referral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_binary_node_ibfk_8805` FOREIGN KEY (`parentId`) REFERENCES `mlm_binary_node` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_binary_node_ibfk_8806` FOREIGN KEY (`leftChildId`) REFERENCES `mlm_binary_node` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_binary_node_ibfk_8807` FOREIGN KEY (`rightChildId`) REFERENCES `mlm_binary_node` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlm_referral`
--
ALTER TABLE `mlm_referral`
  ADD CONSTRAINT `mlm_referral_ibfk_1` FOREIGN KEY (`referrerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_referral_ibfk_2` FOREIGN KEY (`referredId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlm_referral_reward`
--
ALTER TABLE `mlm_referral_reward`
  ADD CONSTRAINT `mlm_referral_reward_ibfk_2253` FOREIGN KEY (`conditionId`) REFERENCES `mlm_referral_condition` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_referral_reward_ibfk_2254` FOREIGN KEY (`referrerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlm_unilevel_node`
--
ALTER TABLE `mlm_unilevel_node`
  ADD CONSTRAINT `mlm_unilevel_node_ibfk_7563` FOREIGN KEY (`referralId`) REFERENCES `mlm_referral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlm_unilevel_node_ibfk_7564` FOREIGN KEY (`parentId`) REFERENCES `mlm_unilevel_node` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_activity`
--
ALTER TABLE `nft_activity`
  ADD CONSTRAINT `nft_activity_ibfk_5182` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_activity_ibfk_5183` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_activity_ibfk_5184` FOREIGN KEY (`listingId`) REFERENCES `nft_listing` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_activity_ibfk_5185` FOREIGN KEY (`fromUserId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_activity_ibfk_5186` FOREIGN KEY (`toUserId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nft_advanced_orders`
--
ALTER TABLE `nft_advanced_orders`
  ADD CONSTRAINT `nft_advanced_orders_ibfk_343` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_advanced_orders_ibfk_344` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_asset`
--
ALTER TABLE `nft_asset`
  ADD CONSTRAINT `nft_asset_ibfk_6597` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_asset_ibfk_6598` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_auction`
--
ALTER TABLE `nft_auction`
  ADD CONSTRAINT `nft_auction_ibfk_1` FOREIGN KEY (`nftAssetId`) REFERENCES `nft_asset` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_bid`
--
ALTER TABLE `nft_bid`
  ADD CONSTRAINT `nft_bid_ibfk_2065` FOREIGN KEY (`listingId`) REFERENCES `nft_listing` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_bid_ibfk_2066` FOREIGN KEY (`bidderId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_bridge_transactions`
--
ALTER TABLE `nft_bridge_transactions`
  ADD CONSTRAINT `nft_bridge_transactions_ibfk_335` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_bridge_transactions_ibfk_336` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_collection`
--
ALTER TABLE `nft_collection`
  ADD CONSTRAINT `nft_collection_ibfk_2119` FOREIGN KEY (`creatorId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_collection_ibfk_2120` FOREIGN KEY (`categoryId`) REFERENCES `nft_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nft_creator`
--
ALTER TABLE `nft_creator`
  ADD CONSTRAINT `nft_creator_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_creator_follows`
--
ALTER TABLE `nft_creator_follows`
  ADD CONSTRAINT `nft_creator_follows_ibfk_1` FOREIGN KEY (`followerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_creator_follows_ibfk_2` FOREIGN KEY (`followingId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_favorite`
--
ALTER TABLE `nft_favorite`
  ADD CONSTRAINT `nft_favorite_ibfk_3072` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_favorite_ibfk_3073` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_favorite_ibfk_3074` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_fraction`
--
ALTER TABLE `nft_fraction`
  ADD CONSTRAINT `nft_fraction_ibfk_331` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_fraction_ibfk_332` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_fraction_ownership`
--
ALTER TABLE `nft_fraction_ownership`
  ADD CONSTRAINT `nft_fraction_ownership_ibfk_329` FOREIGN KEY (`fractionId`) REFERENCES `nft_fraction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_fraction_ownership_ibfk_330` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_listing`
--
ALTER TABLE `nft_listing`
  ADD CONSTRAINT `nft_listing_ibfk_2083` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_listing_ibfk_2084` FOREIGN KEY (`sellerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_menu_configs`
--
ALTER TABLE `nft_menu_configs`
  ADD CONSTRAINT `nft_menu_configs_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `nft_menu_configs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_offer`
--
ALTER TABLE `nft_offer`
  ADD CONSTRAINT `nft_offer_ibfk_4079` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_offer_ibfk_4080` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_offer_ibfk_4081` FOREIGN KEY (`listingId`) REFERENCES `nft_listing` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_offer_ibfk_4082` FOREIGN KEY (`offererId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_rental`
--
ALTER TABLE `nft_rental`
  ADD CONSTRAINT `nft_rental_ibfk_499` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_rental_ibfk_500` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_rental_ibfk_501` FOREIGN KEY (`renterId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nft_review`
--
ALTER TABLE `nft_review`
  ADD CONSTRAINT `nft_review_ibfk_3042` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_review_ibfk_3043` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_review_ibfk_3044` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_review_ibfk_3045` FOREIGN KEY (`creatorId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_royalty`
--
ALTER TABLE `nft_royalty`
  ADD CONSTRAINT `nft_royalty_ibfk_4006` FOREIGN KEY (`saleId`) REFERENCES `nft_sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_royalty_ibfk_4007` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_royalty_ibfk_4008` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_royalty_ibfk_4009` FOREIGN KEY (`recipientId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_sale`
--
ALTER TABLE `nft_sale`
  ADD CONSTRAINT `nft_sale_ibfk_4027` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_sale_ibfk_4028` FOREIGN KEY (`listingId`) REFERENCES `nft_listing` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_sale_ibfk_4029` FOREIGN KEY (`sellerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_sale_ibfk_4030` FOREIGN KEY (`buyerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nft_staking`
--
ALTER TABLE `nft_staking`
  ADD CONSTRAINT `nft_staking_ibfk_486` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_staking_ibfk_487` FOREIGN KEY (`tokenId`) REFERENCES `nft_token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_staking_ibfk_488` FOREIGN KEY (`poolId`) REFERENCES `staking_pools` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nft_token`
--
ALTER TABLE `nft_token`
  ADD CONSTRAINT `nft_token_ibfk_3130` FOREIGN KEY (`collectionId`) REFERENCES `nft_collection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_token_ibfk_3131` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nft_token_ibfk_3132` FOREIGN KEY (`creatorId`) REFERENCES `nft_creator` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_activity_logs`
--
ALTER TABLE `p2p_activity_logs`
  ADD CONSTRAINT `p2p_activity_logs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_admin_activity`
--
ALTER TABLE `p2p_admin_activity`
  ADD CONSTRAINT `p2p_admin_activity_ibfk_1` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_commissions`
--
ALTER TABLE `p2p_commissions`
  ADD CONSTRAINT `p2p_commissions_ibfk_5766` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_commissions_ibfk_5767` FOREIGN KEY (`tradeId`) REFERENCES `p2p_trades` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_commissions_ibfk_5768` FOREIGN KEY (`offerId`) REFERENCES `p2p_offers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `p2p_disputes`
--
ALTER TABLE `p2p_disputes`
  ADD CONSTRAINT `p2p_disputes_ibfk_5742` FOREIGN KEY (`tradeId`) REFERENCES `p2p_trades` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_disputes_ibfk_5743` FOREIGN KEY (`reportedById`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_disputes_ibfk_5744` FOREIGN KEY (`againstId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_offers`
--
ALTER TABLE `p2p_offers`
  ADD CONSTRAINT `p2p_offers_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_offer_flags`
--
ALTER TABLE `p2p_offer_flags`
  ADD CONSTRAINT `p2p_offer_flags_ibfk_3787` FOREIGN KEY (`offerId`) REFERENCES `p2p_offers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_offer_flags_ibfk_3788` FOREIGN KEY (`flaggedById`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `p2p_offer_payment_method`
--
ALTER TABLE `p2p_offer_payment_method`
  ADD CONSTRAINT `p2p_offer_payment_method_ibfk_1` FOREIGN KEY (`offerId`) REFERENCES `p2p_offers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_offer_payment_method_ibfk_2` FOREIGN KEY (`paymentMethodId`) REFERENCES `p2p_payment_methods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_reviews`
--
ALTER TABLE `p2p_reviews`
  ADD CONSTRAINT `p2p_reviews_ibfk_5656` FOREIGN KEY (`reviewerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_reviews_ibfk_5657` FOREIGN KEY (`revieweeId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_reviews_ibfk_5658` FOREIGN KEY (`tradeId`) REFERENCES `p2p_trades` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_reviews_ibfk_5659` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `p2p_trades`
--
ALTER TABLE `p2p_trades`
  ADD CONSTRAINT `p2p_trades_ibfk_7531` FOREIGN KEY (`offerId`) REFERENCES `p2p_offers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_trades_ibfk_7532` FOREIGN KEY (`buyerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_trades_ibfk_7533` FOREIGN KEY (`sellerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `p2p_trades_ibfk_7534` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_intent`
--
ALTER TABLE `payment_intent`
  ADD CONSTRAINT `payment_intent_ibfk_8489` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_intent_ibfk_8490` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_intent_product`
--
ALTER TABLE `payment_intent_product`
  ADD CONSTRAINT `payment_intent_product_ibfk_1` FOREIGN KEY (`paymentIntentId`) REFERENCES `payment_intent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_21241` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post_ibfk_21242` FOREIGN KEY (`authorId`) REFERENCES `author` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD CONSTRAINT `post_tag_ibfk_1903` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post_tag_ibfk_1904` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `provider_user`
--
ALTER TABLE `provider_user`
  ADD CONSTRAINT `provider_user_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `role_permission_ibfk_29596` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_permission_ibfk_29597` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `spot_deposit`
--
ALTER TABLE `spot_deposit`
  ADD CONSTRAINT `spot_deposit_ibfk_10` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spot_deposit_ibfk_9` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_admin_activities`
--
ALTER TABLE `staking_admin_activities`
  ADD CONSTRAINT `staking_admin_activities_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_admin_earnings`
--
ALTER TABLE `staking_admin_earnings`
  ADD CONSTRAINT `staking_admin_earnings_ibfk_1` FOREIGN KEY (`poolId`) REFERENCES `staking_pools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_duration`
--
ALTER TABLE `staking_duration`
  ADD CONSTRAINT `staking_duration_ibfk_1` FOREIGN KEY (`poolId`) REFERENCES `staking_pool` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_earning_records`
--
ALTER TABLE `staking_earning_records`
  ADD CONSTRAINT `staking_earning_records_ibfk_1` FOREIGN KEY (`positionId`) REFERENCES `staking_positions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_external_pool_performances`
--
ALTER TABLE `staking_external_pool_performances`
  ADD CONSTRAINT `staking_external_pool_performances_ibfk_1` FOREIGN KEY (`poolId`) REFERENCES `staking_pools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_log`
--
ALTER TABLE `staking_log`
  ADD CONSTRAINT `staking_log_ibfk_4` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staking_log_ibfk_5` FOREIGN KEY (`poolId`) REFERENCES `staking_pool` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staking_log_ibfk_6` FOREIGN KEY (`durationId`) REFERENCES `staking_duration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staking_positions`
--
ALTER TABLE `staking_positions`
  ADD CONSTRAINT `staking_positions_ibfk_4934` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staking_positions_ibfk_4935` FOREIGN KEY (`poolId`) REFERENCES `staking_pools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `support_ticket`
--
ALTER TABLE `support_ticket`
  ADD CONSTRAINT `support_ticket_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `support_ticket_ibfk_2` FOREIGN KEY (`agentId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_10898` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_10899` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `two_factor`
--
ALTER TABLE `two_factor`
  ADD CONSTRAINT `two_factor_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userblock`
--
ALTER TABLE `userblock`
  ADD CONSTRAINT `userblock_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userblock_ibfk_2` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userdeletion`
--
ALTER TABLE `userdeletion`
  ADD CONSTRAINT `userdeletion_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userdeletion_ibfk_2` FOREIGN KEY (`deletedBy`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wallet`
--
ALTER TABLE `wallet`
  ADD CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wallet_data`
--
ALTER TABLE `wallet_data`
  ADD CONSTRAINT `wallet_data_ibfk_1` FOREIGN KEY (`walletId`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wallet_pnl`
--
ALTER TABLE `wallet_pnl`
  ADD CONSTRAINT `wallet_pnl_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
