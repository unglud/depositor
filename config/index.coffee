config =
  local:
    mode: 'local'
    port: '3000'
    mongo:
      host: 'localhost'
      port: '27017'
      bd: 'depositor'
  staging:
    mode: 'staging'
    port: '4000'
    mongo:
      host: 'depositor:KuUnQWs*pX62@ds063859.mongolab.com'
      port: '63859'
      bd: 'depositor'
  production:
    mode: 'production'
    port: '5000'
    mongo:
      host: 'depositor:KuUnQWs*pX62@ds063859.mongolab.com'
      port: '63859'
      bd: 'depositor'

module.exports = (mode) ->
  config[mode || process.env.MODE || 'local'] || config.local