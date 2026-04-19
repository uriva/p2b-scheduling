---
name: scheduling
description: AI agent skill for scheduling meetings via Calendly and Google Calendar. Check availability, find slots, and manage calendar events using the calendly-token and google-calendar secrets.
---

# Scheduling Skill

This skill provides tools for checking availability and scheduling meetings through Calendly and Google Calendar integrations.

## Secrets Required

- `calendly-token`: Your Calendly API token (for Calendly operations)
- `google-calendar`: Your Google OAuth access token (for Google Calendar operations)

## Tools

### Calendly Tools

- **get_calendly_available_slots**: Get available meeting slots from Calendly for a time range
- **get_calendly_event_types**: List your Calendly event types

### Google Calendar Tools

- **search_calendar_events**: Search for events in a Google Calendar within a time range
- **create_calendar_event**: Create a new event in a Google Calendar
- **update_calendar_event**: Update an existing event in a Google Calendar
- **delete_calendar_event**: Delete an event from a Google Calendar

## Usage

1. First, use `get_calendly_event_types` to see your available event types
2. Use `get_calendly_available_slots` with IANA timezone (e.g., "America/New_York") and local time range (e.g., "2024-01-15T09:00", "2024-01-15T17:00") to find available slots
3. Share the booking URL with the user to let them schedule

For Google Calendar:
- Use `search_calendar_events` with calendar ID and query to find events
- Use `create_calendar_event` to add new events
- Calendar IDs are typically in the format: `<account>@group.calendar.google.com`