expect = require('chai').expect

_ = require('lodash')
Bacon = require('baconjs')
Vector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snakeHeadPosition} = require('../snake')
{Keys} = require('../inputs')

snakeHeadPositionAt00 = (keyPresses) ->
  snakeHeadPosition(Vector(0, 0), keyPresses)

# Remove x from start of line to enable tests
xdescribe 'snake head position', ->
  it 'should have head at (0, 1) after one tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.UP)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1)
    ]

  it 'should have head at (0, 2) after two ticks', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.UP, Keys.UP)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(0, 2)
    ]

  it 'should have head at (1, 0) after one left then tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.LEFT, Keys.UP)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(1, 0)
    ]

  it 'should have head at (1, 1) after tick, left, tick', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.UP, Keys.LEFT, Keys.UP)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(1, 1)
    ]