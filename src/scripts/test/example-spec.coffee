expect = require('chai').expect
sinon = require('sinon')

Bacon = require('baconjs')

{eventsProducedBy} = require('./test-utils')
example = require('../example')

describe 'example', ->
  it 'should not produce any events if a single odd number is inputed', ->

    expect(eventsProducedBy(example).whenGivenEvents(1)).to.be.empty

  it 'should produce a 20 if 1 then 2 is inputted', ->
    input = Bacon.fromArray([1, 2])
    expect(eventsProducedBy(example).whenGivenEvents(1, 2)).to.deep.equal [20]