searchCalendarEvents = (calendarId: string, query: string, timeMin: string, timeMax: string): { id: string, summary: string, start: string, end: string, link: string }[] => {
  token = readSecret({ name: "google-calendar" })
  searchParams = stringConcat({ parts: ["q=", query, "&timeMin=", timeMin, "&timeMax=", timeMax, "&singleEvents=true&orderBy=startTime&maxResults=250"] })
  path = stringConcat({ parts: ["/calendars/", calendarId, "/events?", searchParams.result] })
  res = httpRequest({ host: "www.googleapis.com", method: "GET", path: path.result, headers: { "authorization": token.value } })
  data = jsonParse({ text: res.body })
  return data.items
}

createCalendarEvent = (calendarId: string, summary: string, desc: string, start: string, endTime: string, location: string): { id: string, link: string } => {
  token = readSecret({ name: "google-calendar" })
  path = stringConcat({ parts: ["/calendars/", calendarId, "/events"] })
  body = jsonStringify({ value: { summary: summary, description: desc, location: location, start: { dateTime: start }, end: { dateTime: endTime } } })
  res = httpRequest({ host: "www.googleapis.com", method: "POST", path: path.result, headers: { "authorization": token.value, "content-type": "application/json" }, body: body.text })
  data = jsonParse({ text: res.body })
  return { id: data.id, link: data.htmlLink }
}

updateCalendarEvent = (calendarId: string, eventId: string, summary: string, desc: string, location: string): { id: string, link: string } => {
  token = readSecret({ name: "google-calendar" })
  path = stringConcat({ parts: ["/calendars/", calendarId, "/events/", eventId] })
  updates = pick({ obj: { summary: summary, description: desc, location: location }, keys: ["summary", "description", "location"] })
  body = jsonStringify({ value: updates.result })
  res = httpRequest({ host: "www.googleapis.com", method: "PATCH", path: path.result, headers: { "authorization": token.value, "content-type": "application/json" }, body: body.text })
  data = jsonParse({ text: res.body })
  return { id: data.id, link: data.htmlLink }
}

deleteCalendarEvent = (calendarId: string, eventId: string): { success: boolean } => {
  token = readSecret({ name: "google-calendar" })
  path = stringConcat({ parts: ["/calendars/", calendarId, "/events/", eventId] })
  res = httpRequest({ host: "www.googleapis.com", method: "DELETE", path: path.result, headers: { "authorization": token.value } })
  return { success: res.status == 204 }
}