eventsProducedBy = (observable) ->
  events = []
  observable.onValue (value) ->
    events.push(value)
  return events

module.exports = {eventsProducedBy}