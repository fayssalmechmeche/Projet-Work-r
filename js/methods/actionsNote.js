var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
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

  getNoteByArtisan(req, res) {
    mysqlConnection.query(
      "SELECT * FROM notes WHERE artisanID = ? AND particulierID = ?",
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

  updateNoteOfArtisan(req, res) {
    mysqlConnection.query(
      "UPDATE artisans SET note = ? WHERE _id = ?",
      [req.body.note, req.body.particulierID],
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
