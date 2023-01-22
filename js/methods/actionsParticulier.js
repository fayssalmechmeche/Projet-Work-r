var Particulier = require("../model/particulier");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");

var functions = {
  addNew: function (req, res) {
    if (
      !req.body.name ||
      !req.body.password ||
      !req.body.email ||
      !req.body.username ||
      !req.body.telephone ||
      !req.body.city ||
      !req.body.adress ||
      !req.body.postalCode
    ) {
      res.json({ success: false, msg: "Remplisez tout particulier" });
    } else {
      var newParticulier = Particulier({
        name: req.body.name,
        password: req.body.password,
        email: req.body.email,
        username: req.body.username,
        telephone: req.body.telephone,
        city: req.body.city,
        adress: req.body.adress,
        postalCode: req.body.postalCode,
        picture: req.body.picture,
        chantier: req.body.chantier,
      });
      newParticulier.save(function (err, newParticulier) {
        if (err) {
          res.json({ success: false, msg: "sauvegarde raté part" });
        } else {
          res.json({ success: true, msg: "sauvegarde réussi part" });
        }
      });
    }
  },
  authenticate: function (req, res) {
    Particulier.findOne(
      {
        email: req.body.email,
      },
      function (err, particulier) {
        if (err) throw err;
        if (!particulier) {
          res.status(403).send({
            success: false,
            msg: "Authenticate failed, User not found",
          });
        } else {
          particulier.comparePassword(
            req.body.password,
            function (err, isMatch) {
              if (isMatch && !err) {
                var token = jwt.encode(particulier, config.secret);
                res.json({ success: true, token: token });
              } else {
                return res.status(403).send({
                  success: false,
                  msg: "Authenticate failed, Wrong password",
                });
              }
            }
          );
        }
      }
    );
  },
  getInfo: function (req, res) {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedToken = jwt.decode(token, config.secret);
      return res.json({
        success: true,
        msg: decodedToken,
      });
    } else {
      return res.json({ success: false, msg: "No Headers" });
    }
  },
};
module.exports = functions;
