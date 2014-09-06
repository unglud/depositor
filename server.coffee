config = require('./config')(process.env.MODE)
fs = require 'fs'

# express
express = require 'express'
app = express()

## express middleware
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


# db connect
mongoose = require 'mongoose'
mongoose.connect('mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname);

# templater
ect = require 'ect'
ectRenderer = ect ({ watch: true, root: __dirname + '/views', ext: '.ect' });


# init

app.set 'view engine', 'ect'
app.engine 'ect', ectRenderer.render


app.get '/', (req, res) ->
  res.send 'Hello world'


app.use (err, req, res, next)->
  console.error err.stack
  res
  .status 500
    .send 'Something broke!'

# dynamically include routes (Controller)
fs.readdirSync('./controllers').forEach (file) ->
  if(file.substr(-7) == '.coffee')
    route = require('./controllers/' + file);
    route.controller(app);


server = app.listen process.env.PORT || 5000, ->
  console.log 'Listening on port %d', server.address().port
