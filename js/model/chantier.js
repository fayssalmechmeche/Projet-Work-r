var mongoose = require("mongoose");
var Schema = mongoose.Schema;
var bcrypt = require("bcrypt");
const { use } = require("passport");
var chantierSchema = new Schema({
  name: {
    type: String,
    require: true,
  },
  type: {
    type: String,
    require: true,
  },
  budget: {
    type: String,
    require: true,
  },
  description: {
    type: String,
    require: true,
  },
});
chantierSchema.pre("save", function (next) {
  var chantier = this;
});

module.exports = mongoose.model("Chantier", chantierSchema);
