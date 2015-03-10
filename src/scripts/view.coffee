h = require('virtual-dom/h')
vdomBaconjsRenderder = require('./virtual-dom-renderer')
Bacon = require('baconjs')

px = (num) -> "#{num}px"

square = (x, y, size) ->
  h '.square', { style: { left: px(x), top: px(y), width: px(size), height: px(size) } }

grid = (width, height, gap, size) -> h '.cat', do ->
  actualGap = gap + size
  for y in [0..height]
    for x in [0..width]
      square(x * actualGap, y * actualGap, size)


document.addEventListener 'DOMContentLoaded', ->
  i = 0
  vdomBaconjsRenderder document.body, Bacon.fromPoll 16, ->
    i = (i + 1) % 600 + 1
    grid(10, 10, i / 10, 10 + i / 20)