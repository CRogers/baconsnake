/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as $ from 'jquery'

import { Stream } from './bacon-extras'

export enum Keys {
  LEFT = 37,
  RIGHT = 39,
  UP= 38,
}

export function keyPresses(): Stream<Keys> {
  let keys: Stream<Keys> = $(document).asEventStream('keydown')
      .throttle(20)
      .map(jqEvent => <Keys>jqEvent.which);
  // keys.map((key) => _.invert(Keys)[key]).log('Key pressed:');
  return keys;
}