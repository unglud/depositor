config =
  local:
    mode: 'local'
    port: '3000'
    mongo:
      host: 'localhost'
      port: '27017'
      dbname: 'depositor'
  staging:
    mode: 'staging'
    port: '4000'
    mongo:
      host: process.env.MONGO_HOST
      port: process.env.MONGO_PORT
      dbname: process.env.MONGO_DB
  production:
    mode: 'production'
    port: '5000'
    mongo:
      host: process.env.MONGO_HOST
      port: process.env.MONGO_PORT
      dbname: process.env.MONGO_DB
    loggly:
      token: process.env.LOGGLY_TOKEN

module.exports = (mode) ->
  config[mode || process.env.MODE || 'local'] || config.local


