var webpack = require('webpack');
var MiniCssExtractPlugin = require("mini-css-extract-plugin");
module.exports = {
  entry: {
    site: './source/javascripts/all.js'
  },

  devtool: 'eval-source-map',
  output: {
    path: __dirname + '/.tmp/dist',
    filename: 'javascripts/[name].js',
  },

  module: {
    rules: [
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.css$/, use: MiniCssExtractPlugin.loader },
    ],
    noParse: [
        /\/sinon\.js/
      ],
  },
  module: {
      rules: [{ test: /\.txt$/, use: 'raw-loader'  }],
  },
  resolve: {
    extensions: ['', '.js', '.json', '.coffee'],
    alias: {
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      _: "underscore",
    })
  ]
};
