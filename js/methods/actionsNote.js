var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
  checkNoteExists: function (req, res) {
    const artisanID = req.headers.artisanid;
    const particulierID = req.headers.particulierid;

    mysqlConnection.query(
      "SELECT COUNT(*) AS count FROM notes WHERE artisanID = ? AND particulierID = ?",
      [artisanID, particulierID],
      function (error, results, fields) {
        if (error) {
          return res.json({ success: false, msg: error });
        }

        const count = results[0].count;

        res.json({ exists: count > 0 });
      }
    );
  },

  addNotetoArtisan(req, res) {
    mysqlConnection.query(
      "INSERT INTO notes (note, artisanID, particulierID) VALUES (?, ?, ?)",
      [req.body.note, req.body.artisanID, req.body.particulierID],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({
          success: true,
          msg: "Note ajoutée",
        });
      }
    );
  },
  getOneNoteByArtisan(req, res) {
    mysqlConnection.query(
      "SELECT * FROM notes WHERE artisanID = ? and particulierID = ?",
      [req.headers.artisanid, req.headers.particulierid],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });

        res.json({
          success: true,
          results: results,
        });
      }
    );
  },

  getNoteByArtisan(req, res) {
    mysqlConnection.query(
      "SELECT * FROM notes WHERE artisanID = ?",
      req.headers.artisanid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });

        res.json({
          success: true,
          results: results,
        });
      }
    );
  },

  updateNoteOfArtisan(req, res) {
    mysqlConnection.query(
      "UPDATE artisans SET note = ? WHERE _id = ?",
      [req.body.note, req.body.artisanID],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });

        res.json({
          success: true,
          msg: "Note mise à jour",
        });
      }
    );
  },
};

module.exports = functions;
