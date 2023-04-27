const express = require("express");
const actions = require("../methods/actions");
const actionsArtisan = require("../methods/actionsArtisan");
const actionsParticulier = require("../methods/actionsParticulier");

const router = express.Router();

// test route
router.get("/", (req, res) => {
  res.send("Hello World");
});

// test route
router.get("/dashboard", (req, res) => {
  res.send("dashboard");
});

// insert new user
router.post("/adduser", actions.addNew);

// authenticate user
router.post("/authenticate", actions.authenticate);

// get info user
router.get("/getinfo", actions.getInfo);

// add new artisan
router.post("/addArtisan", actionsArtisan.addNew);

// authenticate artisan
router.post("/authenticateArtisan", actionsArtisan.authenticate);

// update artisan
router.post("/updateArtisan", actionsArtisan.updateArtisan);

// get info artisan
router.get("/getinfoArtisan", actionsArtisan.getInfo);

// get Work By Status of artisan
router.get("/getWorkByStatus", actionsArtisan.getWorkByStatus);

// get All Artisan
router.get("/getAllArtisan", actionsArtisan.getAllArtisan);

// get Recent Artisan
router.get("/getRecentArtisan", actionsArtisan.getRecentArtisan);

// get Chantier By Id Artisan
router.get(
  "/getAllChantiersByArtisan",
  actionsArtisan.getAllChantiersByArtisan
);

// insert new particulier
router.post("/addParticulier", actionsParticulier.addNew);

// update particulier
router.post("/updateParticulier", actionsParticulier.updateParticulier);

// authenticate particulier
router.post("/authenticateParticulier", actionsParticulier.authenticate);

// get info particulier
router.get("/getinfoParticulier", actionsParticulier.getInfo);

// add new chantier to particulier
router.post("/addChantier", actionsParticulier.addChantier);

// get All Chantier By Id Particulier
router.get(
  "/getAllChantiersByParticulier",
  actionsParticulier.getAllChantiersByParticulier
);

module.exports = router;
