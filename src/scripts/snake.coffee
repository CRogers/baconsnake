_ = require('lodash')
Bacon = require('baconjs')

Vector = require('./vector')
{Keys} = require('./inputs')


Direction =
  UP: new Vector(0, -1)
  RIGHT:  new Vector(1, 0)
  DOWN: new Vector(0, 1)
  LEFT:  new Vector(-1, 0)

turnAntiClockwise = (direction) ->
  switch direction
    when Direction.UP    then Direction.LEFT
    when Direction.RIGHT then Direction.UP
    when Direction.DOWN  then Direction.RIGHT
    when Direction.LEFT  then Direction.DOWN

turnClockwise = (direction) ->
  switch direction
    when Direction.UP    then Direction.RIGHT
    when Direction.RIGHT then Direction.DOWN
    when Direction.DOWN  then Direction.LEFT
    when Direction.LEFT  then Direction.UP


snakeHeadPosition = (initialSnakeHeadPosition, keyPresses) ->
  equalTo = (expectedValue) ->
    return (value) -> value == expectedValue

  leftTurns = keyPresses.filter(equalTo(Keys.LEFT)).map(-> turnAntiClockwise)
  rightTurns = keyPresses.filter(equalTo(Keys.RIGHT)).map(-> turnClockwise)

  turns = leftTurns.merge(rightTurns)

  directionFacing = turns.scan Direction.DOWN, (currentDirection, turn) ->
    return turn(currentDirection)

  forwardTick = keyPresses.filter(equalTo(Keys.UP))

  directionFacingOnForwardTick = directionFacing.sampledBy(forwardTick)

  headPosition =
    directionFacingOnForwardTick.scan initialSnakeHeadPosition, (currentPosition, direction) ->
      return currentPosition.add(direction)

  return headPosition


snake = (width, height, keyPresses) ->
  initialPosition = Vector(3, 2)
  headPosition = snakeHeadPosition(initialPosition, keyPresses)

  snakeRenderData = Bacon.combineTemplate
    head: headPosition
    tail: [] # (Steam/property of) a list of vectors, can include head
    food: null # (Stream/property of) a Vector, possibly null

  return snakeRenderData

module.exports = {snake, snakeHeadPosition}