//
const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const erb = require('./loaders/erb')

const webpack = require('webpack')
// const isProduction = process.env.NODE_ENV === 'production'

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('erb', erb)

// if (!isProduction) {
//   const eslint = require('./loaders/eslint')
//   environment.loaders.append('eslint', eslint)
// }

var path = require('path');

environment.plugins.prepend('env',
  new webpack.DefinePlugin({
    'NODE_ENV': JSON.stringify(process.env.NODE_ENV)
  })
)

// added and allow BootstrapVue to work.
const config = environment.toWebpackConfig()
config.resolve = {
  alias: {
    'vue$': 'vue/dist/vue.esm.js',
    '@': path.resolve(__dirname, '../../app/javascript'),
    '@mixins': '@/mixins'
  },
  extensions: ['*', '.js', '.vue', '.json']
}

module.exports = environment
