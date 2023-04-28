var mongoose = require("mongoose");
var Schema = mongoose.Schema;
var bcrypt = require("bcrypt");
const { use } = require("passport");
var artisansSchema = new Schema({
  name: {
    type: String,
    require: true,
  },
  username: {
    type: String,
    require: true,
  },
  telephone: {
    type: String,
    require: true,
  },
  email: {
    type: String,
    require: true,
  },
  picture: {
    type: String,
    require: false,
  },
  siret: {
    type: String,
    require: true,
  },
  mobilite: {
    type: String,
    require: true,
  },
  adress: {
    type: String,
    require: true,
  },
  domaine: {
    type: String,
    require: true,
  },
  entreprise: {
    type: String,
    require: true,
  },
  note: {
    type: String,
    require: false,
  },
  chantier: {
    type: String,
    require: false,
  },
  password: {
    type: String,
    require: true,
  },
});
artisansSchema.pre("save", function (next) {
  var artisan = this;
  if (this.isModified("password") || this.isNew) {
    bcrypt.genSalt(10, function (err, salt) {
      if (err) {
        return next(err);
      }
      bcrypt.hash(artisan.password, salt, function (err, hash) {
        if (err) {
          return next(err);
        }
        artisan.password = hash;
        next();
      });
    });
  } else {
    return next();
  }
});


artisansSchema.methods.comparePassword = function (password, cb) {
  bcrypt.compare(password, this.password, function (err, isMatch) {
    if (err) {
      return cb(err);
    }
    cb(null, isMatch);
  });
};

module.exports = mongoose.model("Artisan", artisansSchema);
