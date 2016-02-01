/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as Bacon from 'baconjs'

import { Stream, Property } from './bacon-extras.ts'
import { Position } from './position.ts'
import { Keys } from './inputs.ts'
import { Snake } from './types.ts'



export function snake(width: number, height: number, keyPresses: Stream<Keys>): Property<Snake> {
    return Bacon.constant({
        head: Position.at(3, 5),
        tail: [],
        food: null
    });
}