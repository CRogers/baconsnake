/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property } from './bacon-extras'
import { Position } from './position'
import { Direction, Turn } from './direction'
import { Keys } from './inputs'
import { Snake } from './types'

function equalTo<T>(expected: T) {
    return (actual: T) => actual === expected
}

function snakeHeadPosition(
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

    const forwardTick: Stream<any> = keyPresses.filter(equalTo(Keys.UP));

    const directionFacingOnUpPress: Stream<Direction> = direction.sampledBy(forwardTick);

    return directionFacingOnUpPress.scan(initialHeadPosition, (lastHeadPosition, directionFacing) => {
        return lastHeadPosition.advance(directionFacing)
    });
}

export function snake(width: number, height: number, keyPresses: Stream<Keys>): Property<Snake> {
    const initialPosition = Position.at(3, 5);
    const headPosition = snakeHeadPosition(initialPosition, keyPresses);
    const snakeRenderData = Bacon.combineTemplate({
        head: headPosition,
        tail: Bacon.constant([]),
        food: null
    });

    return snakeRenderData;
}
