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

  // une fonction pour authentifier un particulier sur la base de donnée mysql avec son email et son mot de passe et renvoyer un token si l'authentification est réussie et un message d'erreur si elle échoue
  authenticate: function (req, res) {
    console.log("email : " + req.body.email);
    console.log("password : " + req.body.password);

    mysqlConnection.query(
      "SELECT * FROM artisans WHERE email = ?",
      req.body.email,
      function (error, results, fields) {
        console.log("results : " + results[0].email);
        // Si l'authentification échoue, renvoyer un message d'erreur
        if (error || results[0] === undefined) {
          console.log("error : " + error);
          return res.status(403).send({
            success: false,
            message: "Authentification échouée. Email introuvable.",
          });

          // Si l'authentification réussie, renvoyer un token
        } else {
          console.log("results : " + results[0].password);
          bcrypt.compare(
            req.body.password,
            results[0].password,
            function (err, isMatch) {
              if (isMatch && !err) {
                console.log("results : " + results[0]);
                var token = jwt.encode(results[0], config.secret);
                res.json({ success: true, token: token });
              } else {
                console.log("error : " + err);
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
