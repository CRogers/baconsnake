module.exports = {
  entry: './src/app.ts',
  output: {
    path: __dirname + '/build',
    publicPath: '/build/',
    filename: 'snake.js'
  },
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee-loader'},
      {test: /\.ts/, loader: 'ts-loader'}
    ]
  }
};