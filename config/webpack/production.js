process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
const merge = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');



module.exports = environment

