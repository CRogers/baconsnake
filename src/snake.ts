/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property } from './bacon-extras.ts'
import { Position } from './position.ts'
import { Direction } from './direction.ts'
import { Keys } from './inputs.ts'
import { Snake } from './types.ts'

function equalTo<T>(expected: T) {
    return (actual: T) => actual == expected
}

function snakeHeadPosition(
    initialHeadPosition: Position,
    keyPresses: Stream<Keys>): Property<Position> {

    const ups: Stream<Keys> = keyPresses.filter(equalTo(Keys.UP));

    const headPostion: Property<Position> = ups.scan(initialHeadPosition, (lastHeadPosition, upKeyPress) => {
        return lastHeadPosition.advance(Direction.up())
    });

    return headPostion;
}

export function snake(width: number, height: number, keyPresses: Stream<Keys>): Property<Snake> {
    const initialPosition = Position.of(3, 5);
    const headPosition = snakeHeadPosition(initialPosition, keyPresses);
    const snakeRenderData = Bacon.combineTemplate({
        head: headPosition,
        tail: Bacon.constant([]),
        food: null
    });

    return snakeRenderData;
}