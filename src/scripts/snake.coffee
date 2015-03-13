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

  spacebars = keyPresses.filter(equalTo(Keys.SPACE))

  directionFacingAtSpace = directionFacing.sampledBy(spacebars)

  headPosition = directionFacingAtSpace.scan initialSnakeHeadPosition, (currentPosition, direction) ->
    return currentPosition.add(direction)

  return headPosition.log()


snake = (width, height, keyPresses) ->
  headPosition = snakeHeadPosition(Vector(3, 2), keyPresses)

  staticSnake = Bacon.combineTemplate
    head: headPosition
    tail: []
    food: null

  return staticSnake

module.exports = {snake, snakeHeadPosition}