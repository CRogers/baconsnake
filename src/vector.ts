/// <reference path="../typings/tsd.d.ts" />

function correctModulo(a: number, m: number): number {
  return ((a % m) + m) % m
}

function randomInt(max: number): number {
  return Math.floor(Math.random() * max)
}

let vectors = {};

export default class Vector {
    constructor(private x: number, private y: number) {}

    // memoize so you can just use javascripts === for equality
    public static of(x: number, y: number): Vector {
        let key = `${x}:${y}`;
        if (vectors[key] == null) {
            vectors[key] = new Vector(x, y)
        }
        return vectors[key]
    }

    public static randomIntVector(xmax: number, ymax: number): Vector {
        return Vector.of(randomInt(xmax), randomInt(ymax));
    }

    add(vector: Vector): Vector {
        return Vector.of(this.x + vector.x, this.y + vector.y)
    }

    modulo(xmod: number, ymod: number): Vector {
        return Vector.of(correctModulo(this.x, xmod), correctModulo(this.y, ymod))
    }

    equals(vector): boolean {
        return vector.x == this.x && vector.y == this.y
    }

    toString(): string {
        return `(${this.x},${this.y}})`
    }
}