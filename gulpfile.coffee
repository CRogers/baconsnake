gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')
jade = require('gulp-jade')
sass = require('gulp-sass')
transform = require('vinyl-transform')
browserify = require('browserify')
rename = require('gulp-rename')

browserified = transform (filename) ->
  browserify(filename).bundle()

paths =
  coffee: './src/scripts/*.coffee'
  sass: './src/css/*.sass'
  jade: './src/html/*.jade'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe(gulp.dest('./build/scripts/'))

gulp.task 'sass', ->
  gulp.src paths.sass
    .pipe(sass(indentedSyntax: true))
    .pipe(gulp.dest('./build/css/'))

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe(jade())
    .pipe(gulp.dest('./build/'))

gulp.task 'browserify', ['coffee', 'sass', 'jade'], ->
  gulp.src('./build/scripts/app.js')
    .pipe(browserified)
    .pipe(rename('baconjs-playground.js'))
    .pipe(gulp.dest('./build/scripts/'))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['browserify'])
  gulp.watch(paths.sass, ['browserify'])
  gulp.watch(paths.jade, ['browserify'])

gulp.task 'test', ['coffee'], ->
  gulp.src('./build/scripts/*-spec.js', {read: false})
    .pipe(mocha())
