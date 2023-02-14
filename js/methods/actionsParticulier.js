var Particulier = require("../model/particulier");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

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
      res.json({ success: false, msg: "veuillez remplir tous les champs" });
    } else {
      const hashedPassword = bcrypt.hashSync(req.body.password, 10);
      console.log(
        "particulier : " + req.body.name,
        req.body.password,
        req.body.email,
        req.body.username,
        req.body.telephone,
        req.body.city,
        req.body.adress,
        req.body.postalCode,
        req.body.picture,
        req.body.chantier
      );
      const queryString = `INSERT INTO particuliers (name, password, email, username, telephone, city, adress, postalCode, picture, chantier)
      VALUES ('${req.body.name}', '${hashedPassword}', '${req.body.email}', '${req.body.username}', '${req.body.telephone}', '${req.body.city}', '${req.body.adress}', '${req.body.postalCode}', '${req.body.picture}', '${req.body.chantier}')`;
      mysqlConnection.query(queryString, function (err, rows, fields) {
        if (!err) {
          res.json({ success: true, msg: "Particulier sauvegardé" });
        } else {
          res.json({ success: false, msg: "Particulier non sauvegardé" });
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
