gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')
jade = require('gulp-jade')
sass = require('gulp-sass')
transform = require('vinyl-transform')
browserify = require('browserify')
rename = require('gulp-rename')
plumber = require('gulp-plumber')
notify = require('gulp-notify')
browserSync = require('browser-sync')
path = require('path')

browserified = ->
  transform (filename) ->
    browserify(filename).bundle()

paths =
  coffee: './src/scripts/{,test}/*.coffee'
  testCoffee: './src/scripts/test/*-spec.coffee'
  sass: './src/css/*.sass'
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

notifyPlumberSass = -> plumber
  errorHandler: (args) ->
    console.log arguments.length
    args.fileName = path.basename(args.fileName)
    notify.onError('''Error: <%= error.message %>
                      at line <%= error.lineNumber %>
                      in file: <%= error.fileName %>''')(args)
    @emit('end')

gulp.task 'sass', ->
  gulp.src paths.sass
    .pipe(notifyPlumberSass())
    .pipe(sass(indentedSyntax: true))
    .pipe(gulp.dest('./build/css/'))
    .pipe(browserSync.reload(stream: true))

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest('./build/'))

gulp.task 'browserify', ['coffee', 'js'], ->
  gulp.src('./build/scripts/app.js')
    .pipe(plumber())
    .pipe(browserified())
    .pipe(rename('baconsnake.js'))
    .pipe(gulp.dest('./build/scripts/'))
    .pipe(browserSync.reload(stream: true))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'build', ['jade', 'sass', 'browserify']

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['browserify', 'test'])
  gulp.watch(paths.sass, ['sass'])
  gulp.watch(paths.jade, ['jade', browserSync.reload])
  #gulp.watch(paths.testCoffee, ['test'])

copy = (src, dest) ->
  gulp.src("#{src}/**/*").pipe(gulp.dest(dest))

gulp.task 'copyMocha', ->
  copy('node_modules/mocha', 'build/scripts/mocha')

gulp.task 'serve', ['build', 'copyMocha', 'watch', 'test'], ->
  browserSync
    server: {baseDir: 'build'}

gulp.task 'test', ['coffee'], ->
  gulp.src(paths.testCoffee, {read: false})
    .pipe(plumber())
    .pipe(mocha())