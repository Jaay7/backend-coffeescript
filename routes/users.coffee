express = require 'express'
router = express.Router()
passport = require 'passport'
jwt = require 'jsonwebtoken'
User = require '../models/user'
dotenv = require 'dotenv'
dotenv.config()

require('../config/passport')(passport)

secret = process.env.SECRET

router.get '/', (req, res) ->
    res.render 'index', { title: 'Home' }


router.post '/register', (req, res, next) -> 
    newUser = new User { 
        name: req.body.name,
        email: req.body.email,
        username: req.body.username,
        password: req.body.password
    }
    User.addUser newUser, (err, user) ->
        if err 
            res.json { success: false, msg: 'Failed to register user' }
        else 
            res.json { success: true, msg: 'User registered' }

router.post '/authenticate', (req, res, next) ->
    username = req.body.username
    password = req.body.password
    User.getUserByUsername username, (err, user) ->
        throw err if err
        if !user
            return res.json { success: false, msg: 'User not found' }
        User.comparePassword password, user.password, (err, isMatch) -> 
            throw err if err
            if isMatch
                token = jwt.sign data: user, secret, {
                    expiresIn: 604800
                }
                res.json {
                    success: true,
                    token: "Bearer #{token}",
                    user: {
                        id: user._id,
                        name: user.name,
                        username: user.username,
                        email: user.email
                    }
                }
            else
                 return res.json { success: false, msg: 'Wrong password' }

router.get '/profile', passport.authenticate('jwt', {session: false}), (req, res, next) ->
    res.json {
        user: {
            _id: req.user._id,
            name: req.user.name,
            username: req.user.username,
            email: req.user.email,
        }
    }

router.get '/profile/:username', (req, res, next) ->
    username = req.params.username
    User.getUserByUsername username, (err, user) ->
        throw err if err
        if !user
            return res.json { success: false, msg: 'User not found' }
        res.json {
            user: {
                _id: user._id,
                name: user.name,
                username: user.username,
                email: user.email,
            }
        }


module.exports = router