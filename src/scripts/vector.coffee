correctModulo = (a, m) -> ((a % m) + m) % m

randomInt = (max) -> Math.floor(Math.random() * max)

class Vector
  constructor: (@x, @y) ->

  add: (vector) ->
    new Vector(@x + vector.x, @y + vector.y)

  modulo: (vector) ->
    new Vector(correctModulo(@x, vector.x), correctModulo(@y, vector.y))

  @randomIntVector: (xmax, ymax) ->
    new Vector(randomInt(xmax), randomInt(ymax))

  @ZERO: new Vector(0, 0)

  equals: (vector) ->
    vector.x == @x and vector.y == @y

  toString: -> "(#{@x},#{@y})"

vectors = {}

# memoize so you can just use javascripts === for equality
makeVector = (x, y) ->
  key = "#{x}:#{y}"
  if not vectors[key]?
    vectors[key] = new Vector(x, y)
  return vectors[key]

module.exports = makeVector