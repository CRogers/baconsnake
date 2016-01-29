module.exports = {
  entry: './src/scripts/app.js',
  output: {
    path: __dirname + '/build',
    filename: 'snake.js'
  },
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee-loader'}
    ]
  }
};