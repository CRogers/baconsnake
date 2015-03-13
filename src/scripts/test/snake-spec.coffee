expect = require('chai').expect

_ = require('lodash')
Bacon = require('baconjs')
Vector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snakeHeadPosition} = require('../snake')
{Keys} = require('../inputs')

tick = 'tick'

snakeHeadPositionAt00 = (events) ->
  tickStream = new Bacon.Bus()
  events
    .filter (event) -> event == tick
    .onValue -> tickStream.push(null)
  return snakeHeadPosition(Vector(0, 0), 3, 3, events, tickStream)

describe 'snake head position', ->
  it 'should have head at (0, 1) after one tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1)
    ]

  it 'should have head at (0, 2) after two ticks', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(tick, tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(0, 2)
    ]

  it 'should have head at (1, 0) after one left then tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.LEFT, tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(1, 0)
    ]

  it 'should have head at (1, 1) after tick, left, tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(tick, Keys.LEFT, tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(1, 1)
    ]

  it 'should wrap around from the left', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.RIGHT, tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(2, 0)
    ]

  it 'should wrap around from the top', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
    .whenGivenEvents(Keys.LEFT, tick, Keys.LEFT, tick)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(1, 0),
      Vector(1, 2),
    ]