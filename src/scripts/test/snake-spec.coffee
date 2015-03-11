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

expectHeadOf = (event) ->
  toEqual: (vector) ->
    expectVector(event.head).toEqual(vector)

describe 'snake', ->
  it 'should have head at (1, 1) after 3 key presses', ->
    input = Bacon.fromArray [Keys.LEFT, Keys.RIGHT, Keys.SPACE]
    firstEvent = eventsProducedBy(snake3x3(input))[0]
    expectHeadOf(firstEvent).toEqual(new Vector(1, 1))