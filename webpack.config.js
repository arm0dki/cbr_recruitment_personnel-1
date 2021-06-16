const path = require('path');
const webpack = require('webpack');
var publicPath = '';
module.exports = (env, options) => {
	console.log('options :>> ', options.mode);
	if(options.mode=='production')
	publicPath= 'Recruitment_Personnel/'
	return {
	module: {
		rules: [
			{
				test: /\.imba$/,
				loader: 'imba/loader',
			},
            {
				test: /\.styl$/,
				use: [
				  {
					loader: "style-loader", // creates style nodes from JS strings
				  },
				  {
					loader: "css-loader", // translates CSS into CommonJS
				  },
				  {
					loader: "stylus-loader", // compiles Stylus to CSS
				  },
				],
            },
            {
                test: /img.+\.(jpe?g|png|gif|svg|ico)$/,
                use: [{
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                        useRelativePath: true,
						outputPath: 'image',
                        publicPath: publicPath+'image'
                    }
                }]
            },			
            {
                test: /fonts.+\.(woff(2)?|ttf|eot|svg)([?#]+\w+)?$/,
                use: [{
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                        useRelativePath: true,
                        outputPath: 'fonts',
                        publicPath: publicPath+'fonts'
                    }
                }]
            },
            {
				test: /\.css$/,
					use: [      
						{
						loader: "style-loader", // creates style nodes from JS strings
						},              				
						{ loader: 'css-loader' },
						{
							loader: 'postcss-loader',
							options: {
								postcssOptions: {
							plugins: [
										['postcss-preset-env']
									]
								},
						sourceMap: true
					}
						}
					]
			}						
		]
	},
	plugins:[
		new webpack.DefinePlugin({
		  'window.TARGET_ENV' : JSON.stringify(options.mode),
		  'window.PUBLIC_PATH': JSON.stringify(publicPath)
		}),
	],
	externals: {
        moment: 'moment'
    },
	devServer: {
		contentBase: path.resolve(__dirname, 'public'),
		watchContentBase: true,
		historyApiFallback: {index: '/index.html'}
	},
	resolve: {
		extensions: [".imba", ".js", ".json"]
	},
	entry: "./src/index.imba",
	output: { path: __dirname + '/dist', filename: "index.js" }
};

}