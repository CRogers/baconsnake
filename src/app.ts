/// <reference path="../typings/tsd.d.ts" />

import './libsetup.ts'

import * as $ from 'jquery'

import { keyPresses } from './inputs'
import { grid } from './view'
import { snake } from './snake';
import { vdomBaconjsRenderer } from './virtual-dom-renderer'

const WIDTH = 10;
const HEIGHT = 10;
const GAP = 2;
const SIZE = 20;

$(() => {
    const snakeRenderDataStream = snake(WIDTH, HEIGHT, keyPresses());
    const snakeGrid = snakeRenderDataStream.map(snakeData => {
        return grid(WIDTH, HEIGHT, GAP, SIZE, snakeData);
    });
    return vdomBaconjsRenderer($('.game')[0], snakeGrid);
});