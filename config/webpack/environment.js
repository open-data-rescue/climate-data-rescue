const { environment } = require('@rails/webpacker')
const isProduction = process.env.NODE_ENV === 'production'

const vue = require('./loaders/vue')
environment.loaders.append('vue', vue)

if (!isProduction) {
  const eslint = require('./loaders/eslint')
  environment.loaders.append('eslint', eslint)
}

module.exports = environment
