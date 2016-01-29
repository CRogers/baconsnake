/// <reference path="../typings/tsd.d.ts" />

import * as _ from 'lodash'
import * as $ from 'jquery'

export enum Keys {
  LEFT = 37,
  RIGHT = 39,
  UP= 38,
}

export function keyPresses() {
  let keys = $(document).asEventStream('keydown')
      .throttle(20)
      .map('.which');
  // keys.map((key) => _.invert(Keys)[key]).log('Key pressed:');
  return keys;
}