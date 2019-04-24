const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const FileManagerPlugin = require('filemanager-webpack-plugin');

module.exports = {
    entry: './src',
    output: {
        path: __dirname + '/bundle',
        filename: 'app.js',
    },
    module: {
        rules: [
            {
                test: /\.js/,
                use: {loader: 'babel-loader'},
                include: __dirname + '/src',
            },
            {
                test: /\.css/,
                use: [MiniCssExtractPlugin.loader, "css-loader"]
            },
            {
                test: /\.(scss)$/,
                use: [
                    {
                        loader: MiniCssExtractPlugin.loader,
                    },
                    {
                        loader: 'css-loader', // translates CSS into CommonJS modules
                    },
                    {
                        loader: 'postcss-loader', // Run post css actions
                        options: {
                            plugins: function () { // post css plugins, can be exported to postcss.config.js
                                return [
                                    require('precss'),
                                    require('autoprefixer')
                                ];
                            }
                        }
                    },
                    {
                        loader: 'sass-loader' // compiles Sass to CSS
                    }
                ]
            },
            {
                test: /.(ttf|otf|eot|svg|woff(2)?)(\?[a-z0-9]+)?$/,
                use: [{
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                        outputPath: 'fonts/',
                        publicPath: '../fonts/'
                    }
                }]
            },
        ],
    },
    plugins: [
        new MiniCssExtractPlugin({
            filename: "app.css",
            chunkFilename: "[id].css"
        }),
        new FileManagerPlugin({
            onEnd: {
                move: [
                    {source: __dirname + '/bundle/app.js', destination: __dirname + '/javascript/app.js'},
                    {source: __dirname + '/bundle/app.css', destination: __dirname + '/stylesheets/app.css'},
                    {source: __dirname + '/bundle/fonts', destination: __dirname + '/fonts'}
                ]
            }
        })
    ]
};

