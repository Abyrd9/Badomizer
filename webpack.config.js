const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const config = {
	mode: 'development',
	module: {
		rules: [
			{
				test: /\.imba$/,
				loader: 'imba/loader',
			},
			{
        test: /\.s[c|a]ss$/,
				use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: ['css-loader', 'postcss-loader', 'sass-loader'],
        })
			},
			{
        test: /\.(gif|png|jpe?g|svg)$/i,
        use: [
          "file-loader",
          {
            loader: "image-webpack-loader",
            options: {
              bypassOnDebug: true
            }
          }
        ]
      },
		]
	},
	resolve: {
		extensions: [".imba",".js", ".json"]
	},
	entry: "./src/client.imba",
	output: {  path: __dirname + '/dist', filename: "client.js" },
	plugins: [
		new ExtractTextPlugin({
			filename: 'index.css',
			allChunks: true,
			disable: process.env.NODE_ENV !== 'production'
    }),
	]
};

if (process.env.NODE_ENV === 'production') {
	config.optimization = {
    minimizer: [
			new UglifyJsPlugin(),
    ]
  }
}

module.exports = config;