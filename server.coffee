config = require('./config')(process.env.MODE)
fs = require 'fs'

# express
express = require 'express'
app = express()

## express middleware

### logger ###
morgan = require 'morgan'
morgan.token 'statusc', (req, res) ->
  color = 32 #green
  status = res.statusCode;

  if status >= 500
    color = 31 # red
  else if status >= 400
    color = 33 # yellow
  else
    color = 36 if status >= 300 # cyan
  return '\x1b[' + color + 'm' + status + '\x1b[0m'

morgan.token 'date', (req, res) ->
  d = new Date()
  d.getDate() + '.' + d.getMonth() + '.' + (d.getFullYear() + '').substr(-2) + ' ' + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds() + '.' + d.getMilliseconds()

app.use(morgan '[:date] :method :url :statusc :res[content-length]B :response-time ms');

if process.env.MODE is 'production'

  ## server logging
  loggly = require('loggly')

  logglyClient = loggly.createClient({
    token: config.loggly.token,
    subdomain: "unglued"
  });

  accessLogStream = {
    write: (line) ->
      logglyClient.log(line);
      return
  }

  app.use(morgan 'combined', {stream: accessLogStream});

### localisation ###
i18n = require 'i18n'
i18n.configure({
  locales:['en', 'ru']
  directory: __dirname + '/locales'
});
app.use(i18n.init);


# db connect
mongoose = require 'mongoose'
mongoose.connect(config.mongo);

# templator
ect = require 'ect'
ectRenderer = ect ({ watch: true, root: __dirname + '/views', ext: '.ect' });
app.set 'view engine', 'ect'
app.engine 'ect', ectRenderer.render

# static files
path = require 'path'
app.use(express.static(path.join(__dirname, 'public')));

# dynamically include routes
require('./lib/boot')(app, { verbose: process.env.MODE=='local' })

# error handle
###app.use (err, req, res, next)->
  console.error err.stack
  res
  .status 500
    .send 'Something broke!'###


app.use((err, req, res, next) ->
  console.error(err.stack)
  res.status(500).render('5xx');
  return
)

## assume 404 since no middleware responded
app.use((req, res, next) ->
  res.status(404).render('404', { url: req.originalUrl });
  return
)

# start server
server = app.listen process.env.PORT || 5000, ->
  console.log 'Listening on port %d', server.address().port