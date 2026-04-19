---
name: scheduling
description: AI agent skill for scheduling meetings via Calendly and Google Calendar.
---

# Scheduling Skill

Tools for checking availability and scheduling meetings through Calendly and Google Calendar.

## Calendly Functions

### getCalendlyEventTypes(calendlyTokenSecretName)
Returns your available event types.

### getCalendlyAvailableSlots(calendlyTokenSecretName, startTime, endTime)
Returns available slots for booking. `startTime` and `endTime` are ISO timestamps.

## Google Calendar Functions

### searchCalendarEvents(googleTokenSecretName, calendarId, query, timeMin, timeMax)
Search events in a calendar. `timeMin`/`timeMax` are ISO timestamps.

### createCalendarEvent(googleTokenSecretName, calendarId, summary, desc, start, endTime, location)
Create a new calendar event.

### updateCalendarEvent(googleTokenSecretName, calendarId, eventId, summary, desc, location)
Update an existing event. Only provide fields to change.

### deleteCalendarEvent(googleTokenSecretName, calendarId, eventId)
Delete an event from the calendar.

## Secret Requirements

Pass the secret name (not the actual token) as the `*SecretName` parameter:
- `calendly-token` - Calendly API token (host: `api.calendly.com`)
- `google-calendar` - Google OAuth token (host: `www.googleapis.com`)

When calling these functions, pass the secret name, e.g., `getCalendlyEventTypes("calendly-token")`