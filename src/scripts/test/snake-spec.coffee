expect = require('chai').expect

_ = require('lodash')
Bacon = require('baconjs')
Vector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snakeHeadPosition} = require('../snake')
{Keys} = require('../inputs')

snakeHeadPositionAt00 = (keyPresses) ->
  snakeHeadPosition(Vector(0, 0), keyPresses)

# These aren't very exciting tests as nothing really happens yet
describe 'snake', ->
  it 'should have head at (0, 0) after one keypress', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.LEFT)

    expect(output).to.deep.equal [
      Vector(0, 0)
    ]

  it 'should have head at (0, 0) after two keypresses', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.UP, Keys.RIGHT)

    expect(output).to.deep.equal [
      Vector(0, 0)
    ]