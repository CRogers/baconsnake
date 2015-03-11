_ = require('lodash')
Bacon = require('baconjs')

makeVector = require('./vector')
{Keys} = require('./inputs')

snakeHeadPosition = (initialSnakeHeadPosition, keyPresses) ->
  equalTo = (expectedValue) ->
    return (value) -> value == expectedValue

  lefts = keyPresses.filter(equalTo(Keys.LEFT)).map(makeVector(-1, 0))
  rights = keyPresses.filter(equalTo(Keys.RIGHT)).map(makeVector(1, 0))

  movementDeltas = lefts.merge(rights)

  headPosition = movementDeltas.scan initialSnakeHeadPosition, (currentPosition, delta) ->
    return currentPosition.add(delta)

  return headPosition

snake = (width, height, keyPresses) ->
  headPosition = snakeHeadPosition(makeVector(0, 0), keyPresses)

  staticSnake = Bacon.combineTemplate
    head: headPosition
    tail: []
    food: null

  return staticSnake

module.exports = {snake, snakeHeadPosition}