var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
    getChantiersById(req, res) {
        console.log(req.headers.testes)
        mysqlConnection.query(
          "SELECT * FROM chantier WHERE id = ?",
          req.headers.testes,
          function (error, results, fields) {
            if (error) return res.json({ success: false, msg: error });
            res.json({ results: results });
          }
        );
      },
};

module.exports = functions;