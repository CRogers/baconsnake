/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property, slidingWindowBy } from './bacon-extras'
import { Position } from './position'
import { Direction, Turn } from './direction'
import { Keys } from './inputs'
import { Snake } from './types'

function equalTo<T>(expected: T) {
    return (actual: T) => actual === expected
}

function snakeHeadPosition(
    width: number,
    height: number,
    initialHeadPosition: Position,
    keyPresses: Stream<Keys>): Property<Position> {

    const leftTurns: Stream<Turn> = keyPresses
        .filter(equalTo(Keys.LEFT))
        .map(() => Direction.turnLeft);

    const rightTurns: Stream<Turn> = keyPresses
        .filter(equalTo(Keys.RIGHT))
        .map(() => Direction.turnRight);

    const turns: Stream<Turn> = leftTurns.merge(rightTurns);

    const direction: Property<Direction> = turns.scan(Direction.up(), (lastDirection, turn) => {
        return turn(lastDirection);
    });

    const forwardTick: Stream<any> = Bacon.repeatedly(250, [null]);

    const directionFacingOnUpPress: Stream<Direction> = direction.sampledBy(forwardTick);

    return directionFacingOnUpPress.scan(initialHeadPosition, (lastHeadPosition, directionFacing) => {
        return lastHeadPosition.advance(directionFacing).modulo(width, height)
    });
}

export function snake(width: number, height: number, keyPresses: Stream<Keys>): Property<Snake> {
    const initialPosition = Position.at(3, 5);
    const headPosition = snakeHeadPosition(width, height, initialPosition, keyPresses);

    const foodPosition: Property<Position> = headPosition.scan(Position.randomlyInArea(width, height), (lastFoodPosition, lastHeadPosition) => {
        if (lastFoodPosition === lastHeadPosition) {
           return Position.randomlyInArea(width, height);
        }
        return lastFoodPosition
    }).skipDuplicates();

    const tailLength: Property<number> = foodPosition.scan(2, length => length + 1);

    return Bacon.combineTemplate({
        head: headPosition,
        tail: slidingWindowBy(headPosition, tailLength),
        food: foodPosition
    });
}
