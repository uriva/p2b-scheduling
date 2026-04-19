---
name: scheduling
description: AI agent skill for scheduling meetings via Calendly and Google Calendar.
---

# Scheduling Skill

Tools for checking availability and scheduling meetings through Calendly and Google Calendar.

## Calendly Functions

### getCalendlyEventTypes(calendlyToken)
Returns your available event types.

### getCalendlyAvailableSlots(calendlyToken, startTime, endTime)
Returns available slots for booking. `startTime` and `endTime` are ISO timestamps.

## Google Calendar Functions

### searchCalendarEvents(googleToken, calendarId, query, timeMin, timeMax)
Search events in a calendar. `timeMin`/`timeMax` are ISO timestamps.

### createCalendarEvent(googleToken, calendarId, summary, desc, start, endTime, location)
Create a new calendar event.

### updateCalendarEvent(googleToken, calendarId, eventId, summary, desc, location)
Update an existing event. Only provide fields to change.

### deleteCalendarEvent(googleToken, calendarId, eventId)
Delete an event from the calendar.

## Secret Requirements

The `calendlyToken` and `googleToken` parameters should be mapped to secrets:
- `calendly-token` - Calendly API token (host: `api.calendly.com`)
- `google-calendar` - Google OAuth token (host: `www.googleapis.com`)