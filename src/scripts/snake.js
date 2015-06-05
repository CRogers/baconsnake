var _ = require('lodash');
var Bacon = require('baconjs');
var Vector = require('./vector');
var Keys = require('./inputs').Keys;

var Direction = {
  UP: new Vector(0, -1),
  RIGHT: new Vector(1, 0),
  DOWN: new Vector(0, 1),
  LEFT: new Vector(-1, 0)
};

var turnAntiClockwise = function(direction) {
  switch (direction) {
    case Direction.UP:
      return Direction.LEFT;
    case Direction.RIGHT:
      return Direction.UP;
    case Direction.DOWN:
      return Direction.RIGHT;
    case Direction.LEFT:
      return Direction.DOWN;
  }
};

var turnClockwise = function(direction) {
  switch (direction) {
    case Direction.UP:
      return Direction.RIGHT;
    case Direction.RIGHT:
      return Direction.DOWN;
    case Direction.DOWN:
      return Direction.LEFT;
    case Direction.LEFT:
      return Direction.UP;
  }
};

var snakeHeadPosition = function(initialSnakeHeadPosition, keyPresses) {
  var equalTo = function(expectedValue) {
    return function(value) {
      return value === expectedValue;
    };
  };

  var leftTurns = keyPresses.filter(equalTo(Keys.LEFT)).map(function() {
    return turnAntiClockwise;
  });

  var rightTurns = keyPresses.filter(equalTo(Keys.RIGHT)).map(function() {
    return turnClockwise;
  });

  var turns = leftTurns.merge(rightTurns);

  var directionFacing = turns.scan(Direction.DOWN, function(currentDirection, turn) {
    return turn(currentDirection);
  });

  var forwardTick = keyPresses.filter(equalTo(Keys.UP));

  var directionFacingOnForwardTick = directionFacing.sampledBy(forwardTick);

  var headPosition = directionFacingOnForwardTick.scan(initialSnakeHeadPosition, function(currentPosition, direction) {
    return currentPosition.add(direction);
  });
  return headPosition;
};

var snake = function(width, height, keyPresses) {
  var initialPosition = Vector(3, 2);
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