config =
  local:
    mode: 'local'
    port: '3000'
    mongo: 'mongodb://localhost:27017/depositor'
  staging:
    mode: 'staging'
    port: '4000'
    mongo: process.env.MONGOLAB_URI
  production:
    mode: 'production'
    port: '5000'
    mongo: process.env.MONGOLAB_URI
    loggly:
      token: process.env.LOGGLY_TOKEN

module.exports = (mode) ->
  config[mode || process.env.MODE || 'local'] || config.local


