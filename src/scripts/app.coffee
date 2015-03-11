$ = require('jquery')
_ = require('lodash')

require('./libsetup')
Vector = require('./vector')
{grid} = require('./view')
inputs = require('./inputs')
vdomBaconjsRenderder = require('./virtual-dom-renderer')

{Keys} = inputs

snake = (width, height, keyPresses, ticks) ->
  property = (prop, submatcher) ->
    return (object) -> submatcher(object[prop])

  equalTo = (expectedValue) ->
    return (value) -> value == expectedValue

  isKey = (key) -> property('which', equalTo(key))

  lefts = keyPresses.filter(isKey(Keys.LEFT)).map('left')
  rights = keyPresses.filter(isKey(Keys.RIGHT)).map('right')

  turns = lefts.merge(rights)

  Direction =
    NORTH: new Vector(0, -1)
    EAST:  new Vector(1, 0)
    SOUTH: new Vector(0, 1)
    WEST:  new Vector(-1, 0)

  turnAntiClockwise = (direction) ->
    switch direction
      when Direction.NORTH then Direction.WEST
      when Direction.EAST  then Direction.NORTH
      when Direction.SOUTH then Direction.EAST
      when Direction.WEST  then Direction.SOUTH

  turnClockwise = (direction) ->
    switch direction
      when Direction.NORTH then Direction.EAST
      when Direction.EAST  then Direction.SOUTH
      when Direction.SOUTH then Direction.WEST
      when Direction.WEST  then Direction.NORTH

  directionFacing = turns.scan Direction.SOUTH, (currentDirection, turn) ->
    switch turn
      when 'left'  then turnAntiClockwise(currentDirection)
      when 'right' then turnClockwise(currentDirection)

  directionFacingAtTick = directionFacing.sampledBy(ticks)

  position = directionFacingAtTick.scan new Vector(0, 0), (currentPosition, direction) ->
    currentPosition.add(direction).modulo(new Vector(width, height))

  foodPosition = position.scan new Vector(5, 5), (currentFoodPosition, snakeHeadPosition) ->
    if currentFoodPosition.equals(snakeHeadPosition)
      return Vector.randomIntVector(width, height)
    return currentFoodPosition
  .skipDuplicates()

  snakeLength = foodPosition.scan 2, (count) -> count + 1

  snake = position
    .slidingWindowBy(snakeLength)
    .map _.compact

  selectedSquares = snake.combine foodPosition, (snakePositions, currentFoodPosition) ->
      snakePositions.concat(currentFoodPosition)
    .map (positions) -> grid(width, height, 2, 20, positions)

  vdomBaconjsRenderder(document.body, selectedSquares)


$ ->
  snake(10, 10, inputs.keyPresses(), Bacon.repeatedly(200, [null]))