/// <reference path="../typings/tsd.d.ts" />

import './libsetup.ts'

import * as $ from 'jquery'

import { keyPresses } from './inputs.ts'
import { grid } from './view.ts'
let {snake} = require('./snake.coffee');
import { vdomBaconjsRenderer } from './virtual-dom-renderer.ts'

const WIDTH = 10;
const HEIGHT = 10;
const GAP = 2;
const SIZE = 20;

$(() => {
    let snakeRenderDataStream = snake(WIDTH, HEIGHT, keyPresses())
    let snakeGrid = snakeRenderDataStream.map(snakeData => {
        return grid(WIDTH, HEIGHT, GAP, SIZE, snakeData);
    });
    return vdomBaconjsRenderer($('.game')[0], snakeGrid);
});