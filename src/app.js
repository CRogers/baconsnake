var $ = require('jquery');
var _ = require('lodash');
require('./libsetup.ts');

var inputs = require('./inputs.ts');
var grid = require('./view.ts').grid;
var snake = require('./snake.coffee').snake;
var vdomBaconjsRenderer = require('./virtual-dom-renderer.ts').default;

var WIDTH = 10;
var HEIGHT = 10;
var GAP = 2;
var SIZE = 20;

$(function() {
  var snakeGrid, snakeRenderDataStream;
  snakeRenderDataStream = snake(WIDTH, HEIGHT, inputs.keyPresses());
  snakeGrid = snakeRenderDataStream.map(function(snakeData) {
    return grid(WIDTH, HEIGHT, GAP, SIZE, snakeData);
  });
  return vdomBaconjsRenderer($('.game')[0], snakeGrid);
});