searchCalendarEvents = (googleToken: string, calendarId: string, query: string, timeMin: string, timeMax: string): { id: string, summary: string, start: string, end: string, link: string }[] => {
  encodedQuery = urlEncode({ text: query })
  encodedTimeMin = urlEncode({ text: timeMin })
  encodedTimeMax = urlEncode({ text: timeMax })
  searchParams = stringConcat({ parts: ["q=", encodedQuery.encoded, "&timeMin=", encodedTimeMin.encoded, "&timeMax=", encodedTimeMax.encoded, "&singleEvents=true&orderBy=startTime&maxResults=250"] })
  path = stringConcat({ parts: ["/calendar/v3/calendars/", calendarId, "/events?", searchParams.result] })
  auth = stringConcat({ parts: ["Bearer ", googleToken] })
  res = httpRequest({ host: "www.googleapis.com", method: "GET", path: path.result, headers: { "authorization": auth.result } })
  isHtml = stringIncludes({ haystack: stringLower({ text: res.body }).result, needle: "<html" })
  shouldParse = res.status == 200 ? (isHtml.result ? false : true) : false
  parsed = shouldParse ? jsonParse({ text: res.body }) : { value: { items: [] } }
  items = parsed.value.items == null ? [] : parsed.value.items
  return items
}

createCalendarEvent = (googleToken: string, calendarId: string, summary: string, desc: string, start: string, endTime: string, location: string): { id: string, link: string } => {
  path = stringConcat({ parts: ["/calendar/v3/calendars/", calendarId, "/events"] })
  auth = stringConcat({ parts: ["Bearer ", googleToken] })
  body = jsonStringify({ value: { summary: summary, description: desc, location: location, start: { dateTime: start }, end: { dateTime: endTime } } })
  res = httpRequest({ host: "www.googleapis.com", method: "POST", path: path.result, headers: { "authorization": auth.result, "content-type": "application/json" }, body: body.text })
  isHtml = stringIncludes({ haystack: stringLower({ text: res.body }).result, needle: "<html" })
  shouldParse = res.status == 200 ? (isHtml.result ? false : true) : false
  parsed = shouldParse ? jsonParse({ text: res.body }) : { value: { id: "", htmlLink: "" } }
  return { id: parsed.value.id, link: parsed.value.htmlLink }
}

updateCalendarEvent = (googleToken: string, calendarId: string, eventId: string, summary: string, desc: string, location: string): { id: string, link: string } => {
  path = stringConcat({ parts: ["/calendar/v3/calendars/", calendarId, "/events/", eventId] })
  auth = stringConcat({ parts: ["Bearer ", googleToken] })
  updates = pick({ obj: { summary: summary, description: desc, location: location }, keys: ["summary", "description", "location"] })
  body = jsonStringify({ value: updates.result })
  res = httpRequest({ host: "www.googleapis.com", method: "PATCH", path: path.result, headers: { "authorization": auth.result, "content-type": "application/json" }, body: body.text })
  isHtml = stringIncludes({ haystack: stringLower({ text: res.body }).result, needle: "<html" })
  shouldParse = res.status == 200 ? (isHtml.result ? false : true) : false
  parsed = shouldParse ? jsonParse({ text: res.body }) : { value: { id: "", htmlLink: "" } }
  return { id: parsed.value.id, link: parsed.value.htmlLink }
}

deleteCalendarEvent = (googleToken: string, calendarId: string, eventId: string): { success: boolean } => {
  path = stringConcat({ parts: ["/calendar/v3/calendars/", calendarId, "/events/", eventId] })
  auth = stringConcat({ parts: ["Bearer ", googleToken] })
  res = httpRequest({ host: "www.googleapis.com", method: "DELETE", path: path.result, headers: { "authorization": auth.result } })
  return { success: res.status == 204 }
}