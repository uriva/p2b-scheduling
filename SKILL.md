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

## Usage

Pass secret names as the token parameters:
- For Calendly: pass `"calendly-token"` as the `calendlyToken` parameter
- For Google Calendar: pass `"google-calendar"` as the `googleToken` parameter

Example:
```
getCalendlyEventTypes("calendly-token")
searchCalendarEvents("google-calendar", "primary", "meeting", "2026-04-19T00:00:00Z", "2026-04-20T00:00:00Z")
```