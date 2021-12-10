express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
cors = require 'cors'
passport = require 'passport'
mongoose = require 'mongoose'
dotenv = require 'dotenv'
dotenv.config()
path = require 'path'

database = process.env.DATABASE

mongoose.Promise = require 'bluebird'
mongoose.connect( database, { useNewUrlParser: true, useUnifiedTopology: true, promiseLibrary: require 'bluebird' } )
    .then( -> console.log "connected to database #{database}")
    .catch( (err) -> console.log "Database error: #{err}" )

app = express()

app.set("view engine", "pug")
app.set("views", path.join(__dirname, "public"))

users = require './routes/users'
products = require './routes/products'
orders = require './routes/orders'

port =  process.env.PORT || 4001

app.use cors()

app.use express.static path.join __dirname, 'public'

app.use bodyParser.json()

app.use passport.initialize()
app.use passport.session()

passport = require './config/passport'

app.use '/users',users
app.use '/products',products
app.use '/orders',orders


app.listen port, ->
    console.log "Server running at port #{port}"