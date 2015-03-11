expect = require('chai').expect
sinon = require('sinon')

Bacon = require('baconjs')

eventsProducedBy = (observable) ->
  events = []
  observable.onValue (value) ->
    events.push(value)
  return events

isEven = (num) -> num % 2 == 0

filterMap = (stream) ->
  stream
    .filter isEven
    .map (num) -> num * 10

describe 'filter + map', ->
  it 'should not produce any events if a single odd number is inputed', ->
    input = Bacon.fromArray([1])
    expect(eventsProducedBy(filterMap(input))).to.be.empty

  it 'should produce a 20 if 1 then 2 is inputted', ->
    input = Bacon.fromArray([1, 2])
    expect(eventsProducedBy(filterMap(input))).to.deep.equal [20]