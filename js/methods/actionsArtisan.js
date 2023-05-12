var Artisan = require("../model/artisan");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
  // add new artisan
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

  // a function to authenticate an artisan on the mysql database with his email and password and return a token if the authentication is successful and an error message if it fails
  authenticate: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans WHERE email = ?",
      req.body.email,

      (error, results) => {
        // If authentification fail, return error message
        if (error || results[0] === undefined) {
          console.log("error : " + error);
          return res.status(403).send({
            success: false,
            message: "Authentification échouée. Email introuvable.",
          });

          // if authentification success, return token
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

  // a function to get the information of an artisan with the jwt token and return his information
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

  // a function to update the information of an artisan from the mysql database with his id and return his information if the update is successful and an error message if it fails
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

  // a function to get all the artisans from the mysql database and return them
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

  // a function to get the 5 most recent artisans from the mysql database and return them
  getRecentArtisan: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM artisans ORDER BY _id DESC LIMIT 5",
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
        console.log(results);
      }
    );
  },

  // a function to get an artisan from the mysql database with his id and return him
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

  // a function to get an artisan from the mysql database with his doamine and return him
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

  // a function to get an work from the mysql database where the state is equal to the state in the header and return it
  getWorkByStatus: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM chantier WHERE state = ? AND (artisans_refuses IS NULL OR artisans_refuses NOT LIKE CONCAT('%', ?, '%'))",
      [req.headers.state, req.headers.artisanid],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results: results });
      }
    );
  },

  // a function to get an work from the mysql database with artisanID and return it
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

  refuseChantier(req, res) {
    console.log(req.body.artisanID);
    console.log(req.body.workID);
    mysqlConnection.query(
      "UPDATE chantier SET artisans_refuses = CONCAT(IFNULL(artisans_refuses, ''),',', ?) WHERE id = ?",
      [req.body.artisanID, req.body.workID],
      function (error, results, fields) {
        console.log(results);
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  // a function to create a pdf to a chantier
  createDevis(req, res) {
    mysqlConnection.query(
      "INSERT INTO devis (particulierID, artisanID, workID, type, category, price, description, pdf, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [
        req.body.particulierID,
        req.body.artisanID,
        req.body.workID,
        req.body.type,
        req.body.category,
        req.body.price,
        req.body.description,
        req.body.pdf,
        1,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  // a function to get all the devis from the mysql database and return them
  getAllDevis(req, res) {
    mysqlConnection.query(
      "SELECT * FROM devis WHERE artisanID = ? AND state != 0",
      req.headers.artisanid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  getDevisByStatus(req, res) {
    mysqlConnection.query(
      "SELECT * FROM devis WHERE artisanID = ? AND state = ?",
      [req.headers.artisanid, req.headers.state],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  ///////////////////////////task////////////////////////////

  // a function to get all the tasks from the mysql database and return them
  getAllTasks(req, res) {
    mysqlConnection.query(
      "SELECT * FROM tache where workID = ?",
      req.headers.workid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  getAllTasksDone(req, res) {
    mysqlConnection.query(
      "SELECT * FROM tache where workID = ? AND state = 1",
      req.headers.workid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  getLastTaskDone(req, res) {
    mysqlConnection.query(
      "SELECT * FROM tache where workID = ? AND state = 1 ORDER BY id DESC LIMIT 1",
      req.headers.workid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  createTask(req, res) {
    mysqlConnection.query(
      "INSERT INTO tache (name, type, start_at, end_at, description, state, workID) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [
        req.body.name,
        req.body.type,
        req.body.startat,
        req.body.endat,
        req.body.description,
        req.body.state,
        req.body.workID,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  updateTask(req, res) {
    mysqlConnection.query(
      "UPDATE tache SET name = ?, type = ?, start_at = ?, end_at = ?, description = ?, state = ? WHERE id = ?",
      [
        req.body.name,
        req.body.type,
        req.body.startat,
        req.body.endat,
        req.body.description,
        req.body.state,
        req.body.taskID,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  deleteTask(req, res) {
    mysqlConnection.query(
      "DELETE FROM task WHERE id = ?",
      req.body.taskID,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ success: true, msg: results });
      }
    );
  },

  ///////////////////////////conversation////////////////////////////

  getAllConversationsFromartisan: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM conversation WHERE artisanID = ?",
      req.headers.artisanid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },
};
module.exports = functions;
