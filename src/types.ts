import { Position } from './position.ts'

export interface Snake {
    head: Position,
    tail: Position[],
    food: Position
}