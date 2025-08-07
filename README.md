# MCP Calendar with supabase

A comprehensive calendar management system that integrates Google Calendar with Supabase database through n8n workflows, providing MCP (Model Context Protocol) tools for AI-powered calendar operations.

## Project Overview

This application provides a complete calendar management solution with the following features:

- **Google Calendar Integration**: Full CRUD operations for calendar events
- **Supabase Database**: Persistent storage of event data with proper indexing
- **n8n Workflows**: Automated workflow management for calendar operations
- **MCP Tools**: AI-accessible tools for calendar management
- **Event Validation**: Conflict detection and availability checking
- **Multi-calendar Support**: Support for multiple Google Calendar accounts

## Prerequisites

Before setting up this project, ensure you have the following:

- **n8n Instance**: A running n8n instance (self-hosted or cloud)
- **Google Cloud Project**: With Google Calendar API enabled
- **Supabase Project**: Database instance with proper permissions
- **Node.js**: Version 16 or higher (for TypeScript compilation)

## Database Setup

### 1. Supabase Configuration

1. Create a new Supabase project at [supabase.com](https://supabase.com)
2. Navigate to the SQL Editor in your Supabase dashboard
3. Execute the migration script located in `migrations/001_create_events_table.sql`

```sql
-- Run the complete migration script
-- This creates the events table with proper indexes and triggers
```

### 2. Database Schema

The application uses the following database schema:

```typescript
interface Event {
  event_id: string;
  event_name: string;
  event_description?: string;
  event_start_date: string;
  event_end_date: string;
  attendances?: string[];
  created_at: string;
  updated_at: string;
  time_zone?: string;
  status: "booked" | "cancelled" | "completed";
  location?: string;
}
```

### 3. Rollback Migration

If needed, use the rollback script `migrations/001_create_events_table_rollback.sql` to revert the database changes.

## n8n Configuration

### 1. Google Calendar Setup

1. **Create Google Cloud Project**:
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Create a new project or select existing one
   - Enable the Google Calendar API

2. **Create OAuth 2.0 Credentials**:
   - Navigate to APIs & Services > Credentials
   - Create OAuth 2.0 Client ID
   - Add authorized redirect URIs for your n8n instance
   - Download the client configuration

3. **Configure n8n Google Calendar Credentials**:
   - In your n8n instance, go to Settings > Credentials
   - Add new Google Calendar OAuth2 API credential
   - Use the client ID and client secret from Google Cloud
   - Test the connection

### 2. Supabase Setup

1. **Get Supabase Credentials**:
   - In your Supabase dashboard, go to Settings > API
   - Copy the Project URL and anon/public key

2. **Configure n8n Supabase Credentials**:
   - In n8n, add new Supabase API credential
   - Enter your Supabase URL and API key
   - Test the connection

### 3. Import Workflow

1. **Import the Main Workflow**:
   - Copy the content from `agents/mcp-calendar.n8n.json`
   - In n8n, go to Workflows > Import from JSON
   - Paste the workflow content
   - Update all placeholder values with your actual credentials

2. **Required Placeholder Replacements**:
   - `YOUR_WEBHOOK_ID_HERE`: Generate a webhook ID in n8n
   - `YOUR_WORKFLOW_ID_HERE`: Use the actual workflow ID from n8n
   - `YOUR_EMAIL@gmail.com`: Your primary Google Calendar email
   - `YOUR_SECONDARY_EMAIL@gmail.com`: Secondary calendar email (if applicable)
   - `YOUR_GOOGLE_CREDENTIAL_ID`: Your Google Calendar credential ID from n8n
   - `YOUR_SUPABASE_CREDENTIAL_ID`: Your Supabase credential ID from n8n

## MCP Tools Configuration

The workflow provides the following MCP tools for AI integration:

### Available Tools

1. **validate_busy_time**: Check if a time slot is available
2. **create_new_event**: Create a new calendar event
3. **delete_event**: Delete an existing event
4. **update_event**: Update event details
5. **get_events_in_gap_time**: Retrieve events within a time range

### Tool Descriptions

- **validate_busy_time**: Validates if a time gap is available before creating events
- **create_new_event**: Creates new events with automatic conflict detection
- **delete_event**: Removes events and updates database status
- **update_event**: Modifies existing events with validation
- **get_events_in_gap_time**: Retrieves event data for a specific time period

## Workflow Operations

### Supported Operations

The workflow handles the following operations based on the `operation` parameter:

1. **getEvent**: Validate event availability
2. **createEvent**: Create new calendar event
3. **deleteEvent**: Delete existing event
4. **updateEvent**: Update event details
5. **getEventData**: Retrieve events in time range

### Input Parameters

All operations accept the following parameters:

- `operation`: The operation to perform
- `startDate`: Event start date (ISO 8601 format)
- `endDate`: Event end date (ISO 8601 format)
- `eventId`: Unique event identifier
- `timeZone`: Timezone for the event
- `eventTitle`: Event title/name
- `summary`: Event description
- `attendee`: Attendee email addresses
- `location`: Event location

## Error Handling

The workflow includes comprehensive error handling:

- **Conflict Detection**: Prevents double-booking
- **Validation Errors**: Ensures data integrity
- **Authentication Errors**: Handles credential issues
- **Database Errors**: Manages Supabase connection issues

## Security Considerations

1. **Credential Management**: Store all credentials securely in n8n
2. **API Key Security**: Use environment variables for sensitive data
3. **Database Security**: Implement proper RLS policies in Supabase
4. **Webhook Security**: Use secure webhook endpoints

## Testing

### Test the Workflow

1. **Manual Testing**:
   - Use the n8n test functionality
   - Verify each operation with sample data
   - Check database entries after operations

2. **MCP Tool Testing**:
   - Test each MCP tool individually
   - Verify proper error handling
   - Check data consistency

### Sample Test Data

```json
{
  "operation": "createEvent",
  "startDate": "2024-01-20T10:00:00.000Z",
  "endDate": "2024-01-20T11:00:00.000Z",
  "eventId": "test-event-001",
  "timeZone": "America/New_York",
  "eventTitle": "Test Meeting",
  "summary": "Test event description",
  "attendee": "test@example.com",
  "location": "Virtual Meeting"
}
```

## Troubleshooting

### Common Issues

1. **Google Calendar Authentication**:
   - Verify OAuth2 credentials are correct
   - Check API quotas and limits
   - Ensure calendar permissions are set

2. **Supabase Connection**:
   - Verify database URL and API key
   - Check network connectivity
   - Ensure proper table permissions

3. **n8n Workflow Issues**:
   - Check credential configurations
   - Verify webhook endpoints
   - Review error logs in n8n

### Debug Steps

1. Check n8n execution logs
2. Verify database connections
3. Test individual nodes
4. Review credential configurations

## Maintenance

### Regular Tasks

1. **Monitor API Quotas**: Check Google Calendar API usage
2. **Database Maintenance**: Review and optimize database performance
3. **Credential Rotation**: Regularly update API keys and tokens
4. **Workflow Updates**: Keep n8n workflows current

### Backup Procedures

1. **Database Backups**: Regular Supabase backups
2. **Workflow Exports**: Export n8n workflows regularly
3. **Configuration Backups**: Document all configuration settings



