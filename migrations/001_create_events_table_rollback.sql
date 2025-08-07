-- Rollback Migration: Drop events table
-- Created: 2024-01-15
-- Description: Rollback migration to drop the events table and all related objects

-- Drop the trigger first
DROP TRIGGER IF EXISTS update_events_updated_at ON events;

-- Drop the function
DROP FUNCTION IF EXISTS update_updated_at_column();

-- Drop the indexes
DROP INDEX IF EXISTS idx_events_start_date;
DROP INDEX IF EXISTS idx_events_status;
DROP INDEX IF EXISTS idx_events_created_at;

-- Drop the table (this will also drop all policies and RLS)
DROP TABLE IF EXISTS events; 