---
name: scheduling
description: AI agent skill for scheduling meetings via Calendly and Google Calendar. Uses safescript for secure, statically-analyzed API calls.
---

# Scheduling Skill

This skill provides tools for checking availability and scheduling meetings through Calendly and Google Calendar integrations.

## Secrets Required

Add these secrets to your bot with matching host allowlists:

- `calendly-token`: Calendly API token (host: `api.calendly.com`)
- `google-calendar`: Google OAuth access token (host: `www.googleapis.com`)

## Usage Pattern

**The secret name parameter must end with `Secretname`** so prompt2bot resolves it before passing to safescript.

### Calendly

1. List event types:
   ```
   getCalendlyEventTypes("calendly-token")
   ```

2. Get available slots (pass ISO timestamps):
   ```
   getCalendlyAvailableSlots("calendly-token", "2024-01-15T09:00:00Z", "2024-01-15T17:00:00Z")
   ```

### Google Calendar

1. Search events:
   ```
   searchCalendarEvents("google-calendar", "your-calendar-id", "meeting", "2024-01-15T00:00:00Z", "2024-01-16T00:00:00Z")
   ```

2. Create event:
   ```
   createCalendarEvent("google-calendar", "primary", "Team Standup", "Daily sync", "2024-01-15T09:00:00Z", "2024-01-15T09:30:00Z", "Zoom")
   ```

3. Update event:
   ```
   updateCalendarEvent("google-calendar", "primary", "event-id", "Updated Title", "New description", "")
   ```

4. Delete event:
   ```
   deleteCalendarEvent("google-calendar", "primary", "event-id")
   ```

## How It Works

These are safescript functions that get converted to tools. Prompt2bot:
1. Statically analyzes which hosts each function contacts
2. Validates against bot secret host policies
3. **Resolves secret names** (parameters ending in `Secretname`) before execution
4. Returns results to the agent