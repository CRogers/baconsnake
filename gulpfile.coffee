gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')
jade = require('gulp-jade')
sass = require('gulp-sass')

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
    .pipe(gulp.dest('./build/html/'))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['test'])
  gulp.watch(paths.sass, ['sass'])
  gulp.watch(paths.jade, ['jade'])

gulp.task 'test', ['coffee'], ->
  gulp.src('./build/scripts/*-spec.js', {read: false})
    .pipe(mocha())
