// //
// const { environment } = require('@rails/webpacker')
// const { VueLoaderPlugin } = require('vue-loader')
// const vue = require('./loaders/vue')
// const erb = require('./loaders/erb')
//
// const webpack = require('webpack')
// // const isProduction = process.env.NODE_ENV === 'production'
//
// environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
// environment.loaders.prepend('vue', vue)
// environment.loaders.prepend('erb', erb)
//
// // if (!isProduction) {
// //   const eslint = require('./loaders/eslint')
// //   environment.loaders.append('eslint', eslint)
// // }
//
// var path = require('path');
//
// environment.plugins.prepend('env',
//   new webpack.DefinePlugin({
//     'NODE_ENV': JSON.stringify(process.env.NODE_ENV)
//   })
// )
//
// environment.plugins.append(
//   "Provide",
//   new webpack.ProvidePlugin({
//     $: "jquery/src/jquery",
//     jQuery: "jquery/src/jquery",
//     Popper: ['popper.js', 'default'],
//     '_': "underscore/underscore.js"
//   })
// );
//
// // added and allow BootstrapVue to work.
// const config = environment.toWebpackConfig()
// config.resolve = {
//   alias: {
//     'vue$': 'vue/dist/vue.esm.js',
//     '@': path.resolve(__dirname, '../../app/javascript'),
//     '@mixins': '@/mixins',
//     underscore: 'underscore/underscore.js',
//     jquery: 'jquery/src/jquery',
//     'jquery-ui/ui/widget': 'blueimp-file-upload/js/vendor/jquery.ui.widget.js',
//     '../img/progressbar.gif': 'blueimp-file-upload/img/progressbar.gif',
//     '../img/loading.gif': 'blueimp-file-upload/img/loading.gif',
//     'jquery-ui': 'jquery-ui-dist',
//     'select2': 'select2/dist',
//     'images/ui-icons_444444_256x240.png': 'jquery-ui-dist/images/ui-icons_444444_256x240.png',
//     'images/ui-icons_555555_256x240.png': 'jquery-ui-dist/images/ui-icons_555555_256x240.png',
//     'images/ui-icons_777620_256x240.png': 'jquery-ui-dist/images/ui-icons_777620_256x240.png',
//     'images/ui-icons_777777_256x240.png': 'jquery-ui-dist/images/ui-icons_777777_256x240.png',
//     'images/ui-icons_cc0000_256x240.png': 'jquery-ui-dist/images/ui-icons_cc0000_256x240.png',
//     'images/ui-icons_ffffff_256x240.png': 'jquery-ui-dist/images/ui-icons_ffffff_256x240.png',
//     'trumbowyg/icons.svg':'trumbowyg/dist/ui/icons.svg'
//   },
//   extensions: ['*', '.js', '.vue', '.json']
// }
//
// module.exports = environment
