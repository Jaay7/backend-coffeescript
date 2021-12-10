mongoose = require 'mongoose'
bcrypt = require 'bcryptjs'

UserSchema = mongoose.Schema {
    name:
        type: String
    email:
        type: String,
        required: true
    username:
        type: String,
        required: true
    password:
        type: String,
        required: true
}
User = module.exports = mongoose.model 'User',UserSchema

module.exports.getUserById = (id, callback) -> 
    User.findById id, callback

module.exports.getUserByUsername = (username, callback) ->
    query = {username: username}
    User.findOne query, callback

module.exports.addUser = (newUser, callback) -> 
    bcrypt.genSalt 10, (err, salt) -> 
        bcrypt.hash newUser.password, salt, (err, hash) -> 
            throw err if err
            newUser.password = hash
            newUser.save callback

module.exports.comparePassword = (candidatePassword, hash, callback) ->
    bcrypt.compare candidatePassword, hash, (err, isMatch) -> 
        throw err if err
        callback null, isMatch