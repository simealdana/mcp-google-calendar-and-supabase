-- Migration: Create events table
-- Created: 2024-01-15
-- Description: Initial migration to create the events table with all necessary indexes and triggers

-- Create the events table
CREATE TABLE events (
  event_id VARCHAR(255) PRIMARY KEY,
  event_name VARCHAR(255) NOT NULL,
  event_description TEXT,
  event_start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  event_end_date TIMESTAMP WITH TIME ZONE NOT NULL,
  attendances TEXT[],
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  time_zone VARCHAR(50),
  status VARCHAR(20) NOT NULL DEFAULT 'booked' CHECK (status IN ('booked', 'cancelled', 'completed')),
  location VARCHAR(500)
);

-- Create indexes for better query performance
CREATE INDEX idx_events_start_date ON events(event_start_date);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_created_at ON events(created_at);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at on row updates
CREATE TRIGGER update_events_updated_at 
  BEFORE UPDATE ON events 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- Note: Security will be handled through API keys and secrets
-- Row Level Security (RLS) is not enabled for this table

-- Add comments for documentation
COMMENT ON TABLE events IS 'Stores calendar events with attendance tracking';
COMMENT ON COLUMN events.event_id IS 'Unique identifier for the event (provided externally)';
COMMENT ON COLUMN events.attendances IS 'Array of email addresses who are attending this event';
COMMENT ON COLUMN events.status IS 'Current status of the event: booked, cancelled, or completed'; 