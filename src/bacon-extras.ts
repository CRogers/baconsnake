/// <reference path="../typings/tsd.d.ts" />

import * as Bacon from 'baconjs'

function doNothing() {}

export type Stream<A> = Bacon.EventStream<any, A>;
export type Property<A> = Bacon.Property<any, A>;
export type Observable<A> = Bacon.Observable<any, A>;

export function slidingWindowBy<T>(
    observable: Observable<T>,
    lengthObs: Observable<number>): Stream<T[]> {

    return Bacon.fromBinder(sink => {
        let buf: T[] = [];
        let length = 0;

        observable.onValue(x => {
            buf.unshift(x);
            buf = buf.slice(0, length);
            sink(new Bacon.Next(buf));
        });

        lengthObs.onValue(n => length = n);

        return doNothing
    });
}
