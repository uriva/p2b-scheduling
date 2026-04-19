getCalendlyEventTypes = (): { uri: string, name: string, slug: string, schedulingUrl: string }[] => {
  token = readSecret({ name: "calendly-token" })
  auth = stringConcat({ parts: ["Bearer ", token.value] })
  userRes = httpRequest({ host: "api.calendly.com", method: "GET", path: "/users/me", headers: auth })
  userData = jsonParse({ text: userRes.body })
  eventsPath = stringConcat({ parts: ["/event_types?user=", userData.resource.uri] })
  eventsRes = httpRequest({ host: "api.calendly.com", method: "GET", path: eventsPath.result, headers: auth })
  eventsData = jsonParse({ text: eventsRes.body })
  return eventsData.collection
}

getCalendlyAvailableSlots = (startTime: string, endTime: string): { name: string, slug: string, slots: { startTime: string, url: string }[] } => {
  token = readSecret({ name: "calendly-token" })
  auth = stringConcat({ parts: ["Bearer ", token.value] })
  userRes = httpRequest({ host: "api.calendly.com", method: "GET", path: "/users/me", headers: auth })
  userData = jsonParse({ text: userRes.body })
  eventsPath = stringConcat({ parts: ["/event_types?user=", userData.resource.uri] })
  eventsRes = httpRequest({ host: "api.calendly.com", method: "GET", path: eventsPath.result, headers: auth })
  eventsData = jsonParse({ text: eventsRes.body })
  event = eventsData.collection[0]
  slotsPath = stringConcat({ parts: ["/event_type_available_times?event_type=", event.uri, "&start_time=", startTime, "&end_time=", endTime] })
  slotsRes = httpRequest({ host: "api.calendly.com", method: "GET", path: slotsPath.result, headers: auth })
  slotsData = jsonParse({ text: slotsRes.body })
  return { name: event.name, slug: event.slug, slots: slotsData.collection }
}