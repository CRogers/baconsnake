expect = require('chai').expect

_ = require('lodash')
Bacon = require('baconjs')
Vector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snake, snakeHeadPosition} = require('../snake')
{Keys} = require('../inputs')

snake3x3 = (keyPresses) ->
  return snake(3, 3, keyPresses, Vector(0, 0))

snakeHeadPositionAt00 = (keyPresses) ->
  snakeHeadPosition(Vector(0, 0), keyPresses)

describe 'snake', ->
  it 'should have head at (0, 1) after one space', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.SPACE)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1)
    ]

  it 'should have head at (0, 2) after two spaces', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.SPACE, Keys.SPACE)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(0, 2)
    ]

  it 'should have head at (1, 0) after one left then space', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.LEFT, Keys.SPACE)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(1, 0)
    ]

  it 'should have head at (1, 1) after space, left, space', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.SPACE, Keys.LEFT, Keys.SPACE)

    expect(output).to.deep.equal [
      Vector(0, 0),
      Vector(0, 1),
      Vector(1, 1)
    ]