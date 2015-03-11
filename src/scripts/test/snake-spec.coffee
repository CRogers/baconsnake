expect = require('chai').expect
sinon = require('sinon')

_ = require('lodash')
Bacon = require('baconjs')
makeVector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snake, snakeHeadPosition} = require('../snake')
{Keys} = require('../inputs')

snake3x3 = (keyPresses) ->
  return snake(3, 3, keyPresses, makeVector(0, 0))

snakeHeadPositionAt00 = (keyPresses) ->
  snakeHeadPosition(makeVector(0, 0), keyPresses)

describe 'snake', ->
  it 'should have head at (1, 0) after one right', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.RIGHT)

    expect(output).to.deep.equal [
      makeVector(0, 0),
      makeVector(1, 0)
    ]

  it 'should have head at (2, 0) after two rights', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.RIGHT, Keys.RIGHT)

    expect(output).to.deep.equal [
      makeVector(0, 0),
      makeVector(1, 0),
      makeVector(2, 0)
    ]

  it 'should have head at (-1, 0) after one left', ->
    output = eventsProducedBy(snakeHeadPositionAt00)
      .whenGivenEvents(Keys.LEFT)

    expect(output).to.deep.equal [
      makeVector(0, 0),
      makeVector(-1, 0)
    ]