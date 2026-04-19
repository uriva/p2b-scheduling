getCalendlyEventTypes = (calendlyToken: string): { uri: string, name: string, slug: string, scheduling_url: string }[] => {
  auth = stringConcat({ parts: ["Bearer ", calendlyToken] })
  userRes = httpRequest({ host: "api.calendly.com", method: "GET", path: "/users/me", headers: { "Authorization": auth.result } })
  isHtml1 = stringIncludes({ haystack: stringLower({ text: userRes.body }).result, needle: "<html" })
  shouldParse1 = userRes.status == 200 ? (isHtml1.result ? false : true) : false
  userData = shouldParse1 ? jsonParse({ text: userRes.body }) : { value: { resource: { uri: "" } } }
  canFetchEvents = shouldParse1 ? true : false
  encodedUserUri = canFetchEvents ? urlEncode({ text: userData.value.resource.uri }) : { encoded: "" }
  eventsPath = stringConcat({ parts: ["/event_types?user=", encodedUserUri.encoded, "&count=100"] })
  eventsRes = canFetchEvents ? httpRequest({ host: "api.calendly.com", method: "GET", path: eventsPath.result, headers: { "Authorization": auth.result } }) : { status: 401, body: "" }
  isHtml2 = stringIncludes({ haystack: stringLower({ text: eventsRes.body }).result, needle: "<html" })
  shouldParse2 = eventsRes.status == 200 ? (isHtml2.result ? false : true) : false
  eventsData = shouldParse2 ? jsonParse({ text: eventsRes.body }) : { value: { collection: [] } }
  eventTypes = eventsData.value.collection ? eventsData.value.collection : []
  return eventTypes
}

getCalendlyAvailableSlots = (calendlyToken: string, startTime: string, endTime: string): { name: string, slug: string, slots: { start_time: string, status: string }[] } => {
  auth = stringConcat({ parts: ["Bearer ", calendlyToken] })
  userRes = httpRequest({ host: "api.calendly.com", method: "GET", path: "/users/me", headers: { "Authorization": auth.result } })
  isHtml1 = stringIncludes({ haystack: stringLower({ text: userRes.body }).result, needle: "<html" })
  shouldParse1 = userRes.status == 200 ? (isHtml1.result ? false : true) : false
  userData = shouldParse1 ? jsonParse({ text: userRes.body }) : { value: { resource: { uri: "" } } }
  canFetchEvents = shouldParse1 ? true : false
  encodedUserUri = canFetchEvents ? urlEncode({ text: userData.value.resource.uri }) : { encoded: "" }
  eventsPath = stringConcat({ parts: ["/event_types?user=", encodedUserUri.encoded, "&count=100"] })
  eventsRes = canFetchEvents ? httpRequest({ host: "api.calendly.com", method: "GET", path: eventsPath.result, headers: { "Authorization": auth.result } }) : { status: 401, body: "" }
  isHtml2 = stringIncludes({ haystack: stringLower({ text: eventsRes.body }).result, needle: "<html" })
  shouldParse2 = eventsRes.status == 200 ? (isHtml2.result ? false : true) : false
  eventsData = shouldParse2 ? jsonParse({ text: eventsRes.body }) : { value: { collection: [] } }
  eventTypes = eventsData.value.collection ? eventsData.value.collection : []
  event = eventTypes.length > 0 ? eventTypes[0] : { uri: "", name: "", slug: "" }
  hasEvent = eventTypes.length > 0 ? true : false
  encodedEventUri = hasEvent ? urlEncode({ text: event.uri }) : { encoded: "" }
  encodedStartTime = urlEncode({ text: startTime })
  encodedEndTime = urlEncode({ text: endTime })
  slotsPath = stringConcat({ parts: ["/event_type_available_times?event_type=", encodedEventUri.encoded, "&start_time=", encodedStartTime.encoded, "&end_time=", encodedEndTime.encoded] })
  slotsRes = hasEvent ? httpRequest({ host: "api.calendly.com", method: "GET", path: slotsPath.result, headers: { "Authorization": auth.result } }) : { status: 204, body: "" }
  isHtml3 = stringIncludes({ haystack: stringLower({ text: slotsRes.body }).result, needle: "<html" })
  shouldParse3 = slotsRes.status == 200 ? (isHtml3.result ? false : true) : false
  slotsData = shouldParse3 ? jsonParse({ text: slotsRes.body }) : { value: { collection: [] } }
  slots = slotsData.value.collection ? slotsData.value.collection : []
  return { name: event.name, slug: event.slug, slots: slots }
}