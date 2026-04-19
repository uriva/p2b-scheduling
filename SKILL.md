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

The agent calls safescript functions with two arguments:

1. **params**: The actual parameter values
2. **secretMapping**: Object mapping parameter names to secret names

### Calendly

1. List event types:
   ```
   run_safescript({
     code: <calendly.ss>,
     functionName: "getCalendlyEventTypes",
     args: {
       params: {},
       secretMapping: { calendlyToken: "calendly-token" }
     }
   })
   ```

2. Get available slots:
   ```
   run_safescript({
     code: <calendly.ss>,
     functionName: "getCalendlyAvailableSlots",
     args: {
       params: { startTime: "2024-01-15T09:00:00Z", endTime: "2024-01-15T17:00:00Z" },
       secretMapping: { calendlyToken: "calendly-token" }
     }
   })
   ```

### Google Calendar

1. Search events:
   ```
   run_safescript({
     code: <google-calendar.ss>,
     functionName: "searchCalendarEvents",
     args: {
       params: { calendarId: "primary", query: "meeting", timeMin: "2024-01-15T00:00:00Z", timeMax: "2024-01-16T00:00:00Z" },
       secretMapping: { googleToken: "google-calendar" }
     }
   })
   ```

2. Create event:
   ```
   run_safescript({
     code: <google-calendar.ss>,
     functionName: "createCalendarEvent",
     args: {
       params: { calendarId: "primary", summary: "Team Standup", desc: "Daily sync", start: "2024-01-15T09:00:00Z", endTime: "2024-01-15T09:30:00Z", location: "Zoom" },
       secretMapping: { googleToken: "google-calendar" }
     }
   })
   ```

3. Delete event:
   ```
   run_safescript({
     code: <google-calendar.ss>,
     functionName: "deleteCalendarEvent",
     args: {
       params: { calendarId: "primary", eventId: "abc123..." },
       secretMapping: { googleToken: "google-calendar" }
     }
   })
   ```

## How It Works

These are safescript functions converted to tools. Prompt2bot:
1. Statically analyzes which hosts each function contacts
2. Validates against bot secret host policies
3. **Resolves secrets** via secretMapping before execution
4. Returns results to the agent

The `secretMapping` ensures the agent explicitly declares which parameters should use secrets, enabling audit and security review.