const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const path = require('path');
const vue = require('./loaders/vue')
const pug =  require('./loaders/pug')

const config = {
  resolve: {
    alias: {
      '@application': path.resolve('app/assets/javascripts/application')
    }
  }
}

environment.config.merge(config)
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('pug', pug)
module.exports = environment

