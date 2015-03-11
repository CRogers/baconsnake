expect = require('chai').expect
sinon = require('sinon')

Bacon = require('baconjs')
Vector = require('../vector')

{eventsProducedBy} = require('./test-utils')
{snake} = require('../snake')
{Keys} = require('../inputs')

snake3x3 = (keyPresses) ->
  return snake(3, 3, keyPresses)

expectVector = (vector) ->
  toEqual: (expectedVector) ->
    expect(vector).to.have.deep.property 'x', expectedVector.x
    expect(vector).to.have.deep.property 'y', expectedVector.y

describe 'snake', ->
  it 'should have head at (1, 1) after 3 key presses', ->
    input = Bacon.fromArray [Keys.LEFT, Keys.RIGHT, Keys.SPACE]
    firstEvent = eventsProducedBy(snake3x3(input))[0]
    expectVector(firstEvent.head).toEqual(new Vector(1, 1))

  it 'should have null food after a key press', ->
    input = Bacon.fromArray [Keys.LEFT]
    firstEvent = eventsProducedBy(snake3x3(input))[0]
    expect(firstEvent.food).to.be.null