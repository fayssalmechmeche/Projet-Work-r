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
      !req.body.lastname ||
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
      const queryString = `INSERT INTO artisans (name,lastname, username, telephone, email, picture, siret, mobilite, adress, domaine, entreprise, note, chantier, password) 
      VALUES ('${req.body.name}','${req.body.lastname}', '${req.body.username}', '${req.body.telephone}', '${req.body.email}', '${req.body.picture}', '${req.body.siret}', '${req.body.mobilite}', '${req.body.adress}', '${req.body.domaine}', '${req.body.entreprise}', '${req.body.note}', '${req.body.chantier}', '${hashedPassword}')`;

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
    mysqlConnection.query(
      "SELECT * FROM artisans WHERE email = ?",
      req.body.email,

      (error, results) => {
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
  updateArtisan: function (req, res) {
    var hashedPassword;
    if (req.body.password != null) {
      hashedPassword = bcrypt.hashSync(req.body.password, 10);
    } else {
      hashedPassword = req.body.password;
    }
    mysqlConnection.query(
      "UPDATE artisans SET name = ?, lastname = ?, password = IFNULL(?, password), email = ?, entreprise = ?, username = ?, telephone = ?, adress = ?, picture = ?, chantier = ? WHERE _id = ?",
      [
        req.body.name,
        req.body.lastname,
        hashedPassword,
        req.body.email,
        req.body.entreprise,
        req.body.username,
        req.body.telephone,
        req.body.adress,
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
  getAllArtisan: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans",
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },
  getRecentArtisan: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans ORDER BY _id DESC",
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },
  getArtisanById: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans WHERE _id = ?",
      req.headers.id,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },
  getArtisanByDomaine: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans WHERE domaine = ?",
      req.headers.domaine,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },

  getWorkByStatus: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM chantier WHERE state = ? ",
      req.headers.state,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },
  getAllChantiersByArtisan(req, res) {
    console.log(req.headers.artisanid);
    mysqlConnection.query(
      "SELECT * FROM chantier WHERE artisanID = ?",
      req.headers.artisanid,
      function (error, results, fields) {
        console.log(results);
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
      }
    );
  },
};
module.exports = functions;
