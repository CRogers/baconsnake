$ = require('jquery')
_ = require('lodash')

require('./libsetup')
require('./test/snake-spec')

inputs = require('./inputs')
grid = require('./view')
{snake} = require('./snake')
vdomBaconjsRenderder = require('./virtual-dom-renderer')

WIDTH = 10
HEIGHT = 10
GAP = 2
SIZE = 20

$ ->
  snakeRenderDataStream = snake(WIDTH, HEIGHT, inputs.keyPresses())

  snakeGrid = snakeRenderDataStream.map (snakeData) -> grid(WIDTH, HEIGHT, GAP, SIZE, snakeData)
  vdomBaconjsRenderder $('.game')[0], snakeGrid