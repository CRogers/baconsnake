class Vector
  constructor: (@x, @y) ->

  add: (vector) ->
    new Vector(@x + vector.x, @y + vector.y)

  equals: (vector) ->
    vector.x == @x and vector.y == @y

  toString: -> "(#{@x},#{@y})"

module.exports = Vector