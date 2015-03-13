_ = require('lodash')
Bacon = require('baconjs')

Vector = require('./vector')
{Keys} = require('./inputs')


snakeHeadPosition = (initialSnakeHeadPosition, keyPresses) ->
  return Bacon.constant(initialSnakeHeadPosition)


snake = (width, height, keyPresses) ->
  initialPosition = Vector(3, 2)
  headPosition = snakeHeadPosition(initialPosition, keyPresses)

  snakeRenderData = Bacon.combineTemplate
    head: headPosition
    tail: [] # List of vectors, can include head
    food: null # Vector, possibly null

  return snakeRenderData

module.exports = {snake, snakeHeadPosition}