-- Migration: Fix transaction amount and fee decimal precision
-- Change from DOUBLE to DECIMAL(36,8) for proper crypto decimal storage

ALTER TABLE `transaction`
  MODIFY COLUMN `amount` DECIMAL(36, 8) NOT NULL COMMENT 'Transaction amount in the wallet''s currency',
  MODIFY COLUMN `fee` DECIMAL(36, 8) DEFAULT 0 COMMENT 'Fee charged for this transaction';