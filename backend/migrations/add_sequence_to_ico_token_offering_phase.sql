-- Migration: Add sequence column to ico_token_offering_phase table
-- Date: 2025-10-13

-- Add sequence column with default value 0
ALTER TABLE `ico_token_offering_phase`
ADD COLUMN `sequence` INT NOT NULL DEFAULT 0 AFTER `duration`;

-- Update existing records to set proper sequence values based on their ID order
-- This assumes phases should be ordered by their creation order (ID)
SET @row_number = 0;
SET @current_offering = '';

UPDATE `ico_token_offering_phase`
JOIN (
    SELECT
        id,
        offeringId,
        @row_number := IF(@current_offering = offeringId, @row_number + 1, 0) as seq,
        @current_offering := offeringId
    FROM `ico_token_offering_phase`
    ORDER BY offeringId, id
) as numbered ON `ico_token_offering_phase`.id = numbered.id
SET `ico_token_offering_phase`.sequence = numbered.seq;
