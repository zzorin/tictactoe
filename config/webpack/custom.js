var path = require('path')

module.exports = {
  resolve: {
    alias: {
      vue: 'vue/dist/vue.js',
      javascript: path.resolve('app/javascript/'),
    }
  }
}
