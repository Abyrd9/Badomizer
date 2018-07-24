const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

const config = {
	mode: 'development',
	module: {
		rules: [
			{
				test: /\.imba$/,
				loader: 'imba/loader',
			}
		]
	},
	resolve: {
		extensions: [".imba",".js", ".json"]
	},
	entry: "./src/client.imba",
	output: {  path: __dirname + '/dist', filename: "client.js" }
};

if (process.env.NODE_ENV === 'production') {
	config.optimization = {
    minimizer: [
			new UglifyJsPlugin(),
    ]
  }
}

module.exports = config;