h = require('virtual-dom/h')
vdomBaconjsRenderder = require('./virtual-dom-renderer')
Bacon = require('baconjs')
_ = require('lodash')

Vector = require('./vector')

px = (num) -> "#{num}px"

square = (x, y, size, extraClass) ->
  className = 'square ' + (extraClass ? '')
  h 'div', { className, style: { left: px(x), top: px(y), width: px(size), height: px(size) } }

classForPosition = (snake, vec) ->
  if vec.equals(snake.head)
    return 'head'

  if snake.food? and vec.equals(snake.food)
    return 'food'

  if (_.find snake.tail, (tailVec) -> vec.equals(tailVec))?
    return 'tail'

  return null

grid = (width, height, gap, size, snake) -> h '.snake-game', do ->
  actualGap = gap + size
  for y in [0...height]
    for x in [0...width]
      extraClass = classForPosition(snake, new Vector(x, y))
      square(x * actualGap, y * actualGap, size, extraClass)

module.exports = grid