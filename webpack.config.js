module.exports = {
  entry: './src/app.ts',
  output: {
    path: __dirname + '/build',
    publicPath: '/build/',
    filename: 'snake.js'
  },
  module: {
    loaders: [
      {test: /\.ts/, loader: 'ts-loader'}
    ]
  },
  resolve: { extensions: ["", ".js", ".ts"] },
};