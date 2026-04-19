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

1. **params**: The parameter values (non-secret params go here)
2. **secretMapping**: Maps parameter names that should use secrets to secret names

### Calendly

1. List event types - `calendlyToken` is mapped to `calendly-token` secret:
   ```
   run_safescript({
     code: <calendly.ss>,
     functionName: "getCalendlyEventTypes",
     args: {
       params: { calendlyToken: "" },
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
       params: { calendlyToken: "", startTime: "2024-01-15T09:00:00Z", endTime: "2024-01-15T17:00:00Z" },
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
       params: { googleToken: "", calendarId: "primary", query: "meeting", timeMin: "2024-01-15T00:00:00Z", timeMax: "2024-01-16T00:00:00Z" },
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
       params: { googleToken: "", calendarId: "primary", summary: "Team Standup", desc: "Daily sync", start: "2024-01-15T09:00:00Z", endTime: "2024-01-15T09:30:00Z", location: "Zoom" },
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
       params: { googleToken: "", calendarId: "primary", eventId: "abc123..." },
       secretMapping: { googleToken: "google-calendar" }
     }
   })
   ```

## How It Works

These are safescript functions converted to tools. When the agent calls:

1. Prompt2bot parses the script and function signature
2. **Validates**: script's target hosts ⊆ secret's allowed hosts
3. **Resolves secrets** via secretMapping - replaces param values with actual secret values
4. Executes the safescript with resolved params
5. Returns results to the agent

The `secretMapping` ensures explicit, auditable coupling between params and secrets.