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
      !req.body.lastname ||
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
      const queryString = `INSERT INTO particuliers (name, lastname, password, email, username, telephone, city, adress, postalCode, picture, chantier)
      VALUES ('${req.body.name}', '${req.body.lastname}', '${hashedPassword}', '${req.body.email}', '${req.body.username}', '${req.body.telephone}', '${req.body.city}', '${req.body.adress}', '${req.body.postalCode}', '${req.body.picture}', '${req.body.chantier}')`;
      mysqlConnection.query(queryString, function (err, rows, fields) {
        if (!err) {
          res.json({ success: true, msg: "Particulier sauvegardé" });
        } else {
          res.json({ success: false, msg: "Particulier non sauvegardé" });
        }
      });
    }
  },
  // une fonction pour authentifier un particulier sur la base de donnée mysql avec son email et son mot de passe et renvoyer un token si l'authentification est réussie et un message d'erreur si elle échoue
  authenticate: function (req, res) {
    console.log("email : " + req.body.email);
    console.log("password : " + req.body.password);

    mysqlConnection.query(
      "SELECT * FROM particuliers WHERE email = ?",
      req.body.email,
      function (error, results, fields) {
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
  updateParticulier: function (req, res) {
    var hashedPassword;
    if (req.body.password != null) {
      hashedPassword = bcrypt.hashSync(req.body.password, 10);
    } else {
      hashedPassword = req.body.password;
    }
    mysqlConnection.query(
      "UPDATE particuliers SET name = ?, password = IFNULL(?, password),lastname = ?, email = ?, username = ?, telephone = ?, city = ?, adress = ?, postalCode = ?, picture = ?, chantier = ? WHERE _id = ?",
      [
        req.body.name,
        hashedPassword,
        req.body.lastname,
        req.body.email,
        req.body.username,
        req.body.telephone,
        req.body.city,
        req.body.adress,
        req.body.postalCode,
        req.body.picture,
        req.body.chantier,
        req.body.id,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  getAllArtisans: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans",
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },
};
module.exports = functions;
