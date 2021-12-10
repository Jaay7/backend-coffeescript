JwtStrategy = require('passport-jwt').Strategy
ExtractJwt = require('passport-jwt').ExtractJwt
User = require '../models/user'
dotenv = require 'dotenv'
dotenv.config()

secret = process.env.SECRET

module.exports = (passport) ->
    opts = {}
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
    opts.secretOrKey = secret;
    passport.use new JwtStrategy opts, (jwt_payload, done) ->
        User.findOne {id: jwt_payload._id}, (err, user) ->
            if err
                return done err,false
            if user
                return done null,user
            else
                 return done null,false