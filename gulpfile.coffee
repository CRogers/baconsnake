gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')
jade = require('gulp-jade')
source = require('vinyl-source-stream')
browserify = require('browserify')
plumber = require('gulp-plumber')
notify = require('gulp-notify')
browserSync = require('browser-sync')
path = require('path')

paths =
  coffee: './src/scripts/{,test}/*.coffee'
  js: './src/scripts/*.js'
  css: './src/css/*.css'
  jade: './src/html/*.jade'

notifyPlumberCoffee = -> plumber
  errorHandler: (args) ->
    args.filename = path.basename(args.filename)
    notify.onError('''Error: <%= error.message %>
                      at line <%= error.location.first_line %> column <%= error.location.first_column %>
                      in file <%= error.filename %>''')(args)
    @emit('end')

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(notifyPlumberCoffee())
    .pipe(coffee())
    .pipe(gulp.dest('./build/scripts/'))

gulp.task 'js', ->
  gulp.src('./src/scripts/*.js')
  .pipe(gulp.dest('./build/scripts/'))

gulp.task 'css', ->
  gulp.src paths.css
    .pipe(gulp.dest('./build/css/'))
    .pipe(browserSync.reload(stream: true))

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest('./build/'))

browserified = ->
  transform (filename) ->
    browserify(filename).bundle()

gulp.task 'browserify', ['coffee', 'js'], ->
  browserify('./build/scripts/app.js')
    .bundle()
    .pipe(source('baconsnake.js'))
    .pipe(gulp.dest('./build/scripts/'))
    .pipe(browserSync.reload(stream: true))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'build', ['jade', 'css', 'browserify']

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['browserify'])
  gulp.watch(paths.js, ['browserify'])
  gulp.watch(paths.css, ['css'])
  gulp.watch(paths.jade, ['jade', browserSync.reload])

copy = (src, dest) ->
  gulp.src("#{src}/**/*").pipe(gulp.dest(dest))

gulp.task 'copyMocha', ->
  copy('node_modules/mocha', 'build/scripts/mocha')

gulp.task 'serve', ['build', 'copyMocha', 'watch'], ->
  browserSync
    server: {baseDir: 'build'}