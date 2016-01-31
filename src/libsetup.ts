/// <reference path="../typings/tsd.d.ts" />

import * as Bacon from 'baconjs'
import * as $ from 'jquery'

$.fn.asEventStream = (<any>Bacon).$.asEventStream;