const express = require("express");
const actions = require("../methods/actions");
const actionsArtisan = require("../methods/actionsArtisan");
const actionsParticulier = require("../methods/actionsParticulier");

const router = express.Router();

router.get("/", (req, res) => {
  res.send("Hello World");
});

router.get("/dashboard", (req, res) => {
  res.send("dashboard");
});

router.post("/adduser", actions.addNew);
router.post("/authenticate", actions.authenticate);
router.get("/getinfo", actions.getInfo);

router.post("/addArtisan", actionsArtisan.addNew);
router.post("/authenticateArtisan", actionsArtisan.authenticate);
router.post("/updateArtisan", actionsArtisan.updateArtisan);
router.get("/getinfoArtisan", actionsArtisan.getInfo);
router.get("/getWorkByStatus", actionsArtisan.getWorkByStatus);
router.get("/getAllArtisan", actionsArtisan.getAllArtisan);
router.get("/getRecentArtisan", actionsArtisan.getRecentArtisan);
router.get(
  "/getAllChantiersByArtisan",
  actionsArtisan.getAllChantiersByArtisan
);

router.post("/addParticulier", actionsParticulier.addNew);
router.post("/updateParticulier", actionsParticulier.updateParticulier);
router.post("/authenticateParticulier", actionsParticulier.authenticate);
router.get("/getinfoParticulier", actionsParticulier.getInfo);
router.post("/addChantier", actionsParticulier.addChantier);
router.get(
  "/getAllChantiersByParticulier",
  actionsParticulier.getAllChantiersByParticulier
);

module.exports = router;
