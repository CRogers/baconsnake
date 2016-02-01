/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property } from './bacon-extras.ts'
import { Vector } from './vector.ts'
import { Direction } from './direction.ts'
import { Keys } from './inputs.ts'

function equalTo<T>(expected: T) {
    return (actual: T) => actual == expected
}

function snakeHeadPosition(
    initialSnakeHeadPostion: Vector,
    keyPresses: Stream<Keys>): Property<Vector> {

    const ups: Stream<Keys> = keyPresses.filter(equalTo(Keys.UP));

    const headPostion: Property<Vector> = ups.scan(initialSnakeHeadPostion, headPosition => {
        return headPosition.advance(Direction.up())
    });

    return headPostion;
}

export function snake(width: number, height: number, keyPresses: Stream<Keys>): Property<{}> {
    const initialPostion = Vector.of(3, 5);
    const headPosition = snakeHeadPosition(initialPostion, keyPresses);
    const snakeRenderData = Bacon.combineTemplate({
        head: headPosition,
        tail: Bacon.constant([]),
        food: null
    });

    return snakeRenderData;
}