h = require('virtual-dom/h')
vdomBaconjsRenderder = require('./virtual-dom-renderer')
Bacon = require('baconjs')

px = (num) -> "#{num}px"

square = (x, y, size) ->
  h '.square', { style: { left: px(x), top: px(y), width: px(size), height: px(size) } }

grid = (width, height, gap) -> h '.cat',
  for y in [0..height]
    for x in [0..width]
      square(x * gap, y * gap, gap - 1)


document.addEventListener 'DOMContentLoaded', ->
  vdomBaconjsRenderder document.body, Bacon.repeatedly(100, [grid(10, 10, 10)])