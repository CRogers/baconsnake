correctModulo = (a, m) -> ((a % m) + m) % m

class Vector
  constructor: (@x, @y) ->

  add: (vector) ->
    new Vector(@x + vector.x, @y + vector.y)

  modulo: (vector) ->
    new Vector(correctModulo(@x, vector.x), correctModulo(@y, vector.y))

  equals: (vector) ->
    vector.x == @x and vector.y == @y

  toString: -> "(#{@x},#{@y})"

module.exports = Vector