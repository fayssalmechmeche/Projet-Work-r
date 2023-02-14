var jwtStrategy = require("passport-jwt").Strategy;
var extractJwt = require("passport-jwt").ExtractJwt;

var config = require("./dbConfig");

module.exports = function (passport) {
  var opts = {};
  opts.secretOrKey = config.secret;
  opts.jwtFromRequest = extractJwt.fromAuthHeaderWithScheme("jwt");
};
