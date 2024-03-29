var Particulier = require("../model/particulier");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
  // add new particulier
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

      const queryString = `INSERT INTO particuliers (name, lastname, password, email, username, telephone, city, adress, postalCode, picture)
      VALUES ('${req.body.name}', '${req.body.lastname}', '${hashedPassword}', '${req.body.email}', '${req.body.username}', '${req.body.telephone}', '${req.body.city}', '${req.body.adress}', '${req.body.postalCode}', '${req.body.picture}')`;
      mysqlConnection.query(queryString, function (err, rows, fields) {
        if (!err) {
          res.json({ success: true, msg: "Particulier sauvegardé" });
        } else {
          res.json({ success: false, msg: "Particulier non sauvegardé" });
        }
      });
    }
  },

  // a function to authenticate a particulier
  authenticate: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM particuliers WHERE email = ?",
      req.body.email,
      function (error, results, fields) {
        // if the email is not found
        if (error || results[0] === undefined) {
          return res.status(403).send({
            success: false,
            message: "Authentification échouée. Email introuvable.",
          });

          // IF THE EMAIL IS FOUND
        } else {
          bcrypt.compare(
            req.body.password,
            results[0].password,
            function (err, isMatch) {
              if (isMatch && !err) {
                var token = jwt.encode(results[0], config.secret);
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

  // if the token is valid, return the user's info
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

  // update a particulier
  updateParticulier: function (req, res) {
    var hashedPassword;
    if (req.body.password != null) {
      hashedPassword = bcrypt.hashSync(req.body.password, 10);
    } else {
      hashedPassword = req.body.password;
    }
    mysqlConnection.query(
      "UPDATE particuliers SET name = ?, password = IFNULL(?, password),lastname = ?, email = ?, username = ?, telephone = ?, city = ?, adress = ?, postalCode = ?, picture = ? WHERE _id = ?",
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
        req.body.id,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  // add a new chantier
  addChantier(req, res) {
    mysqlConnection.query(
      "INSERT INTO chantier (name, type, category, state, budget, description, particulierID, artisanID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        req.body.name,
        req.body.type,
        req.body.category,
        req.body.state,
        req.body.budget,
        req.body.description,
        req.body.particulierID,
        "0",
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  // get all chantiers by particulier
  getAllChantiersByParticulier(req, res) {
    mysqlConnection.query(
      "SELECT * FROM chantier WHERE particulierID = ?",
      req.headers.particulierid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
      }
    );
  },

  // get favorite artisans of a particulier
  getFavoriteArtisanOfParticulier(req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans WHERE FIND_IN_SET(_id, (SELECT favorite FROM particuliers WHERE _id = ?))",
      req.headers.particulierid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
      }
    );
  },

  // add a favorite artisan to a particulier
  addFavoriteArtisanToParticulier(req, res) {
    const particulierId = req.body.particulierID;
    const artisanId = req.body.artisanID;

    mysqlConnection.query(
      "UPDATE particuliers SET favorite = CONCAT(IFNULL(favorite,''), ',', ?) WHERE _id = ?",
      [artisanId, particulierId],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({
          success: true,
          msg: "Artisan ajouté aux favoris du particulier",
        });
      }
    );
  },
  removeFavoriteArtisanToParticulier(req, res) {
    const particulierId = req.body.particulierID;
    const artisanId = req.body.artisanID;

    mysqlConnection.query(
      "UPDATE particuliers SET favorite = REPLACE(favorite, CONCAT(',', ?), '') WHERE _id = ?",
      [artisanId, particulierId],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({
          success: true,
          msg: "Artisan retiré des favoris du particulier",
        });
      }
    );
  },

  checkFavoriteArtisanForParticulier(req, res) {
    const particulierId = req.body.particulierID;
    const artisanId = req.body.artisanID;

    mysqlConnection.query(
      "SELECT favorite FROM particuliers WHERE _id = ?",
      [particulierId],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });

        const favorites = results[0].favorite;
        const favoriteArtisans = favorites ? favorites.split(",") : [];

        const isFavorite = favoriteArtisans.includes(artisanId);

        res.json({
          success: true,
          isFavorite: isFavorite,
        });
      }
    );
  },

  getDevisParticulierByWork(req, res) {
    mysqlConnection.query(
      "SELECT * FROM devis WHERE particulierID = ? AND workID = ?",
      [req.headers.test1, req.headers.test2],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  getAllDevis(req, res) {
    mysqlConnection.query(
      "SELECT * FROM devis WHERE particulierID = ? AND state != 0",
      req.headers.particulierid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  getActifDevisByWork(req, res) {
    mysqlConnection.query(
      "SELECT * FROM devis WHERE state = 3 AND workID = ?",
      req.headers.workid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  refuseDevis(req, res) {
    mysqlConnection.query(
      "UPDATE devis SET state = 2 WHERE id = ? AND particulierID = ?",
      [req.body.devisID, req.body.particulierID],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: "Devis refusé" });
      }
    );
  },
  // "UPDATE devis SET particulier_refuses = CONCAT(IFNULL(particulier_refuses, ''),',', ?) WHERE id = ?"

  acceptDevis(req, res) {
    mysqlConnection.query(
      "UPDATE chantier SET state = 1, artisanID = ? WHERE id = ?",
      [req.body.artisanID, req.body.workID]
    );
    mysqlConnection.query(
      "UPDATE devis SET state = 3 WHERE id = ? AND particulierID = ?",
      [req.body.devisID, req.body.particulierID],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: "Devis accepté" });
      }
    );
  },
  // get all artisans
  getAllParticuliers: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM particuliers",
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },
  getParticulierById: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM particuliers WHERE _id = ?",
      req.headers.id,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  /////////////////////////////// CONVERSATION ///////////////////////////////

  getAllConversationsFromParticulier: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM conversation WHERE particulierID = ?",
      req.headers.particulierid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },
};
module.exports = functions;
