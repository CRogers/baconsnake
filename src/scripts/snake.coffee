_ = require('lodash')
Bacon = require('baconjs')

Vector = require('./vector')
{Keys} = require('./inputs')

snakeHeadPosition = (initialSnakeHeadPosition, keyPresses) ->
  equalTo = (expected) ->
    return (actual) -> actual == expected

  ups = keyPresses.filter(equalTo(Keys.UP))

  headPosition = ups.scan initialSnakeHeadPosition, (headPosition, rightKeyPress) ->
    return headPosition.add(Vector(0, -1))

  return headPosition


snake = (width, height, keyPresses) ->
  initialPosition = Vector(3, 5)
  headPosition = snakeHeadPosition(initialPosition, keyPresses)

  snakeRenderData = Bacon.combineTemplate
    head: headPosition
    tail: [] # (Steam/property of) a list of vectors, can include head
    food: null # (Stream/property of) a Vector, possibly null

  return snakeRenderData

module.exports = {snake, snakeHeadPosition}