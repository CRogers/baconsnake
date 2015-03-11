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

describe 'snake', ->
  it 'should have head at (1, 0) after one right', ->
    input = Bacon.fromArray [Keys.RIGHT]
    output = eventsProducedBy(snakeHeadPosition(makeVector(0, 0), input))
    expect(output).to.deep.equal [makeVector(0, 0)]

  it 'should have null food after a key press', ->
    input = Bacon.fromArray [Keys.LEFT]
    firstEvent = eventsProducedBy(snake3x3(input))[0]
    expect(firstEvent.food).to.be.null