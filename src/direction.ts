/// <reference path="../typings/tsd.d.ts" />

import { Position } from './vector.ts'

export class Direction {
    constructor(private direction: Position) {}

    public static up(): Direction {
        return new Direction(Position.of(0, -1))
    }

    public static fromComponents(x: number, y: number): Direction {
        return new Direction(Position.of(x, y));
    }

    turnRight(): Direction {
        return Direction.fromComponents(this.direction.y, -this.direction.x);
    }

    turnLeft(): Direction {
        return Direction.fromComponents(-this.direction.y, this.direction.x);
    }

    asVector(): Position{
        return this.direction;
    }
}