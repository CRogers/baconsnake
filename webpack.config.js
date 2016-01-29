module.exports = {
  entry: './src/app.js',
  output: {
    path: __dirname + '/build',
    filename: 'snake.js'
  },
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee-loader'},
      {test: /\.ts/, loader: 'ts-loader'}
    ]
  }
};