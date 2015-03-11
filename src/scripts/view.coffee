h = require('virtual-dom/h')
vdomBaconjsRenderder = require('./virtual-dom-renderer')
Bacon = require('baconjs')
_ = require('lodash')

Vector = require('./vector')

px = (num) -> "#{num}px"

square = (x, y, size, selected) ->
  className = 'square' + (if selected then ' selected' else '')
  h 'div', { className, style: { left: px(x), top: px(y), width: px(size), height: px(size) } }

grid = (width, height, gap, size, selection) -> h '.snake-game', do ->
  actualGap = gap + size
  for y in [0...height]
    for x in [0...width]
      selected = (_.find selection, (vec) -> vec.equals(new Vector(x, y)))?
      square(x * actualGap, y * actualGap, size, selected)

module.exports = {grid}