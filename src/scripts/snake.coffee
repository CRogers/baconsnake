_ = require('lodash')
Bacon = require('baconjs')

Vector = require('./vector')
{Keys} = require('./inputs')

snake = (width, height, keyPresses) ->
  keyPresses.log('key pressed:')

  snakeHeadPosition = Bacon.once(new Vector(1, 1))

  staticSnake = Bacon.combineTemplate
    head: snakeHeadPosition
    tail: []
    food: null

  return staticSnake

module.exports = {snake}