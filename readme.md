Baconsnake!
===

Make the classic game [Snake](http://en.wikipedia.org/wiki/Snake_(video_game)) using Functional Reactive Programming in
coffeescript via [Bacon.js](https://github.com/baconjs/bacon.js/#baconjs).

Setup
---

1. Clone this git repo
2. Make sure you have node and npm installed (if not, `brew install node`)
3. At the repo root, run `npm install`.

Dev Environment
---

To run the game, type `./gulp serve` at the root of the directory. The code and tests will be recompiled on the fly and your
browser will autoreload when necessary. You can tweak these settings in `gulpfile.coffee`.

The tests should run automatically after changes when running `./gulp serve`, however you can run them sepeartely using `./gulp
 test`.