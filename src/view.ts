/// <reference path="../typings/tsd.d.ts" />

import { h } from 'virtual-dom'
import * as _ from 'lodash'

import { Position } from './position'
import { Snake } from './types'

function px(num) { return `${num}px` }

function square(x: number, y: number, size: number, extraClass?: string) {
    let className = 'square ' + (extraClass ? extraClass : '');
    var style = {left: px(x), top: px(y), width: px(size), height: px(size)};
    return h('div', {className, style}, []);
}

function classForPosition(snake, vec): string {
    if (vec.equals(snake.head)) {
        return 'head'
    }

    if (snake.food != null && vec.equals(snake.food)) {
        return 'food';
    }

    if (_.find(snake.tail, (tailVec) => vec.equals(tailVec)) != null) {
        return 'tail';
    }

    return null;
}

export function grid(width: number, height: number, gap: number, size: number, snake: Snake): VirtualDOM.VTree {
    let actualGap = gap + size;
    let pixelHeight = px(actualGap * height);
    let squares = [];
    for(let y = 0; y < height; y++) {
        for (let x = 0; x < width; x++) {
            let extraClass = classForPosition(snake, Position.at(x, y));
            squares.push(square(x * actualGap, y * actualGap, size, extraClass));
        }
    }
    return h('.snake-game', {style: {height: pixelHeight}}, squares);

}