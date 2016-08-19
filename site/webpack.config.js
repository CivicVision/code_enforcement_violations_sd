var webpack = require('webpack');
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
    loaders: [
      { test: /\**\/*coffee$/, loader: "coffee-loader", exclude: /node_modules|\.tmp/},
      { test: /\.css$/, loader: "style-loader!css-loader" },
    ],
    noParse: [
        /\/sinon\.js/
      ],
  },
  resolve: {
    extensions: ['', '.js', '.json', '.coffee'],
    alias: {
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      _: "underscore",
			vega: "vega",
      "vega-lite": "vega-lite",
      "vega-embed": "vega-embed"
    })
  ]
};
