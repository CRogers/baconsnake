/// <reference path="../typings/tsd.d.ts" />

import {Direction} from "./direction";
function correctModulo(a: number, m: number): number {
  return ((a % m) + m) % m
}

function randomInt(max: number): number {
  return Math.floor(Math.random() * max)
}

let vectors = {};

export class Position {
    constructor(public x: number, public y: number) {}

    // memoize so you can just use javascripts === for equality
    public static at(x: number, y: number): Position {
        let key = `${x}:${y}`;
        if (vectors[key] == null) {
            vectors[key] = new Position(x, y)
        }
        return vectors[key]
    }

    public static randomlyInArea(xmax: number, ymax: number): Position {
        return Position.at(randomInt(xmax), randomInt(ymax));
    }

    add(vector: Position): Position {
        return Position.at(this.x + vector.x, this.y + vector.y)
    }

    advance(direction: Direction) {
        return this.add(direction.asVector());
    }

    modulo(xmod: number, ymod: number): Position {
        return Position.at(correctModulo(this.x, xmod), correctModulo(this.y, ymod))
    }

    equals(vector: Position): boolean {
        return vector.x == this.x && vector.y == this.y
    }

    toString(): string {
        return `(${this.x},${this.y}})`
    }
}