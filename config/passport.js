var jwtStrategy = require('passport-jwt').Strategy
var extractJwt = require('passport-jwt').ExtractJwt

var User = require('../model/user')
var config = require('./dbConfig')

module.exports = function(passport) {
    var opts = {}
    opts.secretOrKey = config.secret
    opts.jwtFromRequest = extractJwt.fromAuthHeaderWithScheme('jwt')
    passport.use(new jwtStrategy(opts, function(jwt_payload,done){
        User.find({
            id:jwt_payload
        }, function(err,user) {
            if(err){
                return done(err,false)
            }
            if(user){
                return done(null,user)
            }
            else {
                return done(null,false)
            }
            
        }
        )
    }))
}