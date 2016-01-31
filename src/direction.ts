/// <reference path="../typings/tsd.d.ts" />

import { Vector } from './vector.ts'

export class Direction {
    constructor(private direction: Vector) {}

    public static up(): Direction {
        return new Direction(Vector.of(0, 1))
    }

    public static fromComponents(x: number, y: number): Direction {
        return new Direction(Vector.of(x, y));
    }

    turnRight(): Direction {
        return Direction.fromComponents(this.direction.y, -this.direction.x);
    }

    turnLeft(): Direction {
        return Direction.fromComponents(-this.direction.y, this.direction.x);
    }

    asVector(): Vector{
        return this.direction;
    }
}