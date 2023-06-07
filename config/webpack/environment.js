const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
const merge = require('webpack-merge');

const defaults = environment.toWebpackConfig()
const path = require('path')


function resolve (dir) {
  return path.join(__dirname, '..', dir)
}

const options = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript'),
      '@views': path.resolve(__dirname, '..', '..', 'app/javascript/views'),
      '@assets': path.resolve(__dirname, '..', '..', 'app/javascript/assets'),
      '@components': path.resolve(__dirname, '..', '..', 'app/javascript/components'),
      '@node_modules': path.resolve(__dirname, '..', '..', 'node_modules'),
    }
  },
  module: {
    rules: [
      // {
      //   test: /\.vue$/,
      //   loader: 'vue-loader'
      // },
      {
        test: /\.pug$/,
        loader: 'pug-plain-loader'
      },

      // {
      //   test: /\.css$/,
      //   use: ['vue-style-loader', 'css-loader']
      // },


    ]
  }
};

module.exports = merge(defaults, options )

