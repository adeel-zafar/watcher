const webpack = require('webpack');
const path = require('path');

module.exports = {
  entry: './src/js/index.js',
  output: {
    path: path.resolve(__dirname, './bin'),
    filename: 'index.bundle.js'
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel-loader',
      query: {
        presets: ['es2015']
      }
    }]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
        mangle: {
          toplevel: true
        },
        compress: {
          warnings: false,
          unused: true,
          dead_code: true,
          conditionals: true,
          comparisons: true,
          sequences: true,
          evaluate: true,
          if_return: true,
          join_vars: true,
          negate_iife: false,
          properties: true,
          drop_debugger: true,
          unsafe: false,
          booleans: true,
          loops: true,
          hoist_funs: true,
          hoist_vars: false,
          cascade: true,
          side_effects: true,
          warnings: true,
        },
        output: {
          comments: false,
        },
      }),
    ]
 };
