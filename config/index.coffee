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
      host: 'depositor:KuUnQWs*pX62@ds033390.mongolab.com'
      port: '33390'
      dbname: 'heroku_app29232518'
  production:
    mode: 'production'
    port: '5000'
    mongo:
      host: 'depositor:KuUnQWs*pX62@ds063859.mongolab.com'
      port: '63859'
      dbname: 'depositor'

module.exports = (mode) ->
  config[mode || process.env.MODE || 'local'] || config.local