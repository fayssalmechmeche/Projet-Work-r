var Artisan = require("../model/artisan");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
  addNew: function (req, res) {
    if (
      !req.body.name ||
      !req.body.username ||
      !req.body.telephone ||
      !req.body.email ||
      !req.body.siret ||
      !req.body.mobilite ||
      !req.body.adress ||
      !req.body.domaine ||
      !req.body.entreprise ||
      !req.body.password
    ) {
      res.json({ success: false, msg: "veuillez remplir tous les champs" });
    } else {
      const hashedPassword = bcrypt.hashSync(req.body.password, 10);
      const queryString = `INSERT INTO artisans (name, username, telephone, email, picture, siret, mobilite, adress, domaine, entreprise, note, chantier, password) 
      VALUES ('${req.body.name}', '${req.body.username}', '${req.body.telephone}', '${req.body.email}', '${req.body.picture}', '${req.body.siret}', '${req.body.mobilite}', '${req.body.adress}', '${req.body.domaine}', '${req.body.entreprise}', '${req.body.note}', '${req.body.chantier}', '${hashedPassword}')`;

      mysqlConnection.query(queryString, function (err, rows, fields) {
        if (!err) {
          res.json({ success: true, msg: "Artisan sauvegardé" });
        } else {
          res.json({ success: false, msg: "Artisan non sauvegardé" });
        }
      });
    }
  },

  authenticate: function (req, res) {
    Artisan.findOne(
      {
        email: req.body.email,
      },
      function (err, artisan) {
        if (err) throw err;
        if (!artisan) {
          return res.status(403).send({
            success: false,
            msg: "Authenticate failed, User not found",
          });
        } else {
          artisan.comparePassword(req.body.password, function (err, isMatch) {
            if (isMatch && !err) {
              var token = jwt.encode(artisan, config.secret);
              res.json({ success: true, token: token });
            } else {
              return res.status(403).send({
                success: false,
                msg: "Authenticate failed, Wrong password",
              });
            }
          });
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
