expect = require('chai').expect
sinon = require('sinon')
example = require('../example')

Bacon = require('baconjs')

eventsProducedBy = (observable) ->
  events = []
  observable.onValue (value) ->
    events.push(value)
  return events

describe 'example', ->
  it 'should not produce any events if a single odd number is inputed', ->
    input = Bacon.fromArray([1])
    expect(eventsProducedBy(example(input))).to.be.empty

  it 'should produce a 20 if 1 then 2 is inputted', ->
    input = Bacon.fromArray([1, 2])
    expect(eventsProducedBy(example(input))).to.deep.equal [20]