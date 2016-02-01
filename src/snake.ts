/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property } from './bacon-extras.ts'
import { Position } from './position.ts'
import { Direction } from './direction.ts'
import { Keys } from './inputs.ts'
import { Snake } from './types.ts'

function equalTo<T>(expected: T) {
    return (actual: T) => actual === expected
}

type Turn = (direction: Direction) => Direction;

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

    const ups: Stream<any> = keyPresses.filter(equalTo(Keys.UP));

    const directionFacingOnUpPress: Stream<Direction> = direction.sampledBy(ups);

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