var path = require('path');
var webpack = require('webpack');
var merge = require('webpack-merge');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer = require('autoprefixer');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');


const prod = 'production';
const dev = 'development';

// determine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? prod : dev;
var isDev = TARGET_ENV == dev;
var isProd = TARGET_ENV == prod;

// set entry and output path/filename
var entryPath = path.join(__dirname, 'src/static/index.js');
var outputPath = path.join(__dirname, 'dist');
var outputFilename = isProd ? '[name]-[hash].js' : '[name].js'

console.log('WEBPACK GO! Building for ' + TARGET_ENV);

// var styleLoaders = [{
//     loader: 'css-loader',
//     options: {
//         modules: true,
//         sourceMap: isDev,
//         //localIdentName: isProd ? '[name]-[hash].css' : '[name].css'
//     }
// }, {
//     loader: 'postcss-loader'
// }, {
//     loader: 'sass-loader',
//     options: {
//         modules: true,
//         sourceMap: isDev,
//         includePaths: ['node_modules']
//     }
// }]

// common webpack config (valid for dev and prod)

var commonConfig = {
    output: {
        path: outputPath,
        filename: `static/js/${outputFilename}`,
        // publicPath: '/'
    },
    resolve: {
        extensions: ['.js', '.elm'],
        modules: ['node_modules']
    },
    module: {
        noParse: /\.elm$/,
        rules: [{
            test: /\.(eot|ttf|woff|woff2|svg)$/,
            use: 'file-loader?publicPath=../../&name=static/css/[hash].[ext]'
        }, {
            test: /\.sc?ss$/,
            use: ExtractTextPlugin.extract({
                fallback: 'style-loader',
                use: ['css-loader', 'postcss-loader', 'sass-loader']
            })
        }]
    },
    plugins: [
        new ExtractTextPlugin({
            filename: 'static/css/[name]-[hash].css',
            allChunks: true,
        }),
        new webpack.LoaderOptionsPlugin({
            options: {
                postcss: [autoprefixer()]
            }
        }),
        new HtmlWebpackPlugin({
            template: 'src/static/index.html',
            inject: 'body',
            filename: 'index.html'
        })
    ]
}

// additional webpack settings for local env (when invoked by 'npm start')
if (isDev === true) {
    module.exports = merge(commonConfig, {
        entry: [
            'webpack-dev-server/client?http://localhost:8080',
            entryPath
        ],
        devServer: {
            // serve index.html in place of 404 responses
            historyApiFallback: true,
            contentBase: './src',
            hot: true
        },
        module: {
            rules: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: 'elm-webpack-loader?verbose=true&warn=true&debug=true'
            }]
        }
    });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (isProd === true) {
    module.exports = merge(commonConfig, {
        entry: entryPath,
        module: {
            rules: [{
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: 'elm-webpack-loader'
            }]
        },

        plugins: [
            new CopyWebpackPlugin([{
                from: 'src/static/img/',
                to: 'static/img/'
            }, {
                from: 'src/favicon.ico'
            }]),

            // extract CSS into a separate file
            //
            // // minify & mangle JS/CSS
            new webpack.optimize.UglifyJsPlugin({
                minimize: true,
                compressor: {
                    warnings: false
                }
                // mangle:  true
            })
        ]

    });
}
