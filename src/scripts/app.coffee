require('./libsetup')
require('./view')
{inputs, Keys} = require('./inputs')

property = (prop, submatcher) ->
  return (object) -> submatcher(object[prop])

equalTo = (expectedValue) ->
  return (value) -> value == expectedValue

isKey = (key) -> property('which', equalTo(key))

lefts = inputs.filter(isKey(Keys.LEFT)).map('left')
rights = inputs.filter(isKey(Keys.RIGHT)).map('right')

turns = lefts.merge(rights)

Direction =
  NORTH: '^'
  EAST:  '>'
  SOUTH: 'v'
  WEST:  '<'

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

directionFacing = turns.scan Direction.NORTH, (currentDirection, turn) ->
  switch turn
    when 'left'  then turnAntiClockwise(currentDirection)
    when 'right' then turnClockwise(currentDirection)


directionFacing.log()