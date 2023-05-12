const express = require("express");
const actions = require("../methods/actions");
const actionsArtisan = require("../methods/actionsArtisan");
const actionsParticulier = require("../methods/actionsParticulier");
const actionsConversation = require("../methods/actionsConversation");

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

// get Artisan By Id
router.get("/getArtisanById", actionsArtisan.getArtisanById);

// get Recent Artisan
router.get("/getRecentArtisan", actionsArtisan.getRecentArtisan);

// get Chantier By Id Artisan
router.get(
  "/getAllChantiersByArtisan",
  actionsArtisan.getAllChantiersByArtisan
);
router.get("/getAllTasksDone", actionsArtisan.getAllTasksDone);
router.get("/getAllTasks", actionsArtisan.getAllTasks);
router.get("/getLastTaskDone", actionsArtisan.getLastTaskDone);
router.post("/createTask", actionsArtisan.createTask);
router.post("/updateTask", actionsArtisan.updateTask);

// create Devis to Chantier

router.post("/createDevis", actionsArtisan.createDevis);

router.get("/getAllDevis", actionsArtisan.getAllDevis);

router.get("/getDevisByStatus", actionsArtisan.getDevisByStatus);

router.post("/refuseChantier", actionsArtisan.refuseChantier);

router.get(
  "/getAllConversationsFromArtisan",
  actionsArtisan.getAllConversationsFromArtisan
);

///////////////////////////Particulier//////////////////////////////

// insert new particulier
router.post("/addParticulier", actionsParticulier.addNew);

// update particulier
router.post("/updateParticulier", actionsParticulier.updateParticulier);

router.get("/getParticulierById", actionsParticulier.getParticulierById);

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
router.get("/getAllDevisParticulier", actionsParticulier.getAllDevis);

router.get("/getActifDevisByWork", actionsParticulier.getActifDevisByWork);

router.post("/refuseDevis", actionsParticulier.refuseDevis);

router.post("/accepteDevis", actionsParticulier.acceptDevis);

router.post(
  "/addFavoriteArtisanToParticulier",
  actionsParticulier.addFavoriteArtisanToParticulier
);

router.get(
  "/getFavoriteArtisanOfParticulier",
  actionsParticulier.getFavoriteArtisanOfParticulier
);

router.get(
  "/getAllConversationsFromParticulier",
  actionsParticulier.getAllConversationsFromParticulier
);

///////////////////////////Conversation//////////////////////////////

router.get(
  "/checkConversationExists",
  actionsConversation.checkConversationExists
);

router.post("/createConversation", actionsConversation.createConversation);

router.get("/getOneConversation", actionsConversation.getOneConversation);

router.get(
  "/getAllConversationFromArtisanAndParticulier",
  actionsConversation.getAllConversationFromArtisanAndParticulier
);

router.get(
  "/getAllMessagesForSenderFromConversation",
  actionsConversation.getAllMessagesForSenderFromConversation
);

router.get(
  "/getAllMessagesForReceiverFromConversation",
  actionsConversation.getAllMessagesForReceiverFromConversation
);

router.get(
  "/getAllMessagesFromPublicConversation",
  actionsConversation.getAllMessagesFromPublicConversation
);

router.post("/sendMessagePublic", actionsConversation.sendMessagePublic);

///////////////////////////CHANTIER Conversation//////////////////////////////

router.get(
  "/checkChantierConversationExists",
  actionsConversation.checkChantierConversationExists
);

router.post(
  "/createChantierConversation",
  actionsConversation.createChantierConversation
);

router.get(
  "/getOneConversationFromWork",
  actionsConversation.getOneConversationFromWork
);

router.post("/sendMessage", actionsConversation.sendMessage);

router.get(
  "/getAllMessagesFromConversation",
  actionsConversation.getAllMessagesFromConversation
);

module.exports = router;
