var Artisan = require("../model/artisan");
var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");

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
      var newArtisan = Artisan({
        name: req.body.name,
        username: req.body.username,
        telephone: req.body.telephone,
        email: req.body.email,
        picture: req.body.picture,
        siret: req.body.siret,
        mobilite: req.body.mobilite,
        adress: req.body.adress,
        domaine: req.body.domaine,
        entreprise: req.body.entreprise,
        note: req.body.note,
        chantier: req.body.chantier,
        password: req.body.password,
      });
      newArtisan.save(function (err, newArtisan) {
        if (err) {
          res.json({ success: false, msg: "sauvegarde raté artisans" });
        } else {
          res.json({ success: true, msg: "sauvegarde réussi artisans" });
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
          return res
            .status(403)
            .send({
              success: false,
              msg: "Authenticate failed, User not found",
            });
        } else {
          artisan.comparePassword(req.body.password, function (err, isMatch) {
            if (isMatch && !err) {
              var token = jwt.encode(artisan, config.secret);
              res.json({ success: true, token: token });
            } else {
              return res
                .status(403)
                .send({
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
        msg: "hello " + decodedToken.name + " mdp : " + decodedToken.password,
      });
    } else {
      return res.json({ success: false, msg: "No Headers" });
    }
  },
};
module.exports = functions;
