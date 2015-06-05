var _ = require('lodash');
var Bacon = require('baconjs');
var Vector = require('./vector');
var Keys = require('./inputs').Keys;

var snakeHeadPosition = function(initialSnakeHeadPosition, keyPresses) {
  var equalTo = function(expected) {
    return function(actual) {
      return actual === expected;
    };
  };

  var ups = keyPresses.filter(equalTo(Keys.UP));

  var headPosition = ups.scan(initialSnakeHeadPosition, function(headPosition, rightKeyPress) {
    return headPosition.add(Vector(0, -1));
  });

  return headPosition;
};

var snake = function(width, height, keyPresses) {
  var initialPosition = Vector(3, 5);
  var headPosition = snakeHeadPosition(initialPosition, keyPresses);

  var snakeRenderData = Bacon.combineTemplate({
    head: headPosition,
    tail: Bacon.constant([]),
    food: null
  });
  return snakeRenderData;
};

module.exports = {
  snake: snake,
  snakeHeadPosition: snakeHeadPosition
};