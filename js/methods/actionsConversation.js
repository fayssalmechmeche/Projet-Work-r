var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
  checkConversationExists: function (req, res) {
    const artisanID = req.headers.artisanid;
    const particulierID = req.headers.particulierid;
    console.log(artisanID);
    console.log(particulierID);

    mysqlConnection.query(
      "SELECT COUNT(*) AS count FROM conversation WHERE artisanID = ? AND particulierID = ?",
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
  createConversation: function (req, res) {
    mysqlConnection.query(
      "INSERT INTO conversation (artisanID, particulierID, name) VALUES (?, ?, ?)",
      [req.body.artisanID, req.body.particulierID, req.body.name],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  // Get all conversations
  getAllConversationFromArtisanAndParticulier: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM conversation WHERE artisanID = ? AND particulierID = ?",
      [req.headers.artisanid, req.headers.particulierid],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  getAllMessagesForSenderFromConversation: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM message WHERE conversationID = ? AND senderID = ? and sender_type = ?",
      [
        req.headers.conversationid,
        req.headers.senderid,
        req.headers.sendertype,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  getAllMessagesForReceiverFromConversation: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM message WHERE conversationID = ? AND receiverID = ? and receiver_type = ?",
      [
        req.headers.conversationid,
        req.headers.receiverid,
        req.headers.receivertype,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  /////// CHANTIER CONVERSATION ///////

  checkChantierConversationExists: function (req, res) {
    mysqlConnection.query(
      "SELECT COUNT(*) AS count FROM conversation_chantier WHERE workID = ?",
      [req.headers.workid],
      function (error, results, fields) {
        if (error) {
          return res.json({ success: false, msg: error });
        }

        const count = results[0].count;
        res.json({ exists: count > 0 });
      }
    );
  },
  createChantierConversation: function (req, res) {
    mysqlConnection.query(
      "INSERT INTO conversation_chantier (artisanID, particulierID, workID) VALUES (?, ?, ?)",
      [req.body.artisanID, req.body.particulierID, req.body.workID],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  getOneConversationFromWork: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM conversation_chantier WHERE workID = ?",
      req.headers.workid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },

  sendMessage: function (req, res) {
    mysqlConnection.query(
      "INSERT INTO message (conversationID, senderID, pseudo, sender_type, content) VALUES (?, ?, ?, ?, ?)",
      [
        req.body.conversationID,
        req.body.senderID,
        req.body.pseudo,
        req.body.sender_type,
        req.body.content,
      ],
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json(results);
      }
    );
  },

  getAllMessagesFromConversation: function (req, res) {
    mysqlConnection.query(
      "SELECT * FROM message WHERE conversationID = ?",
      req.headers.conversationid,
      function (error, results, fields) {
        if (error) return res.json({ success: false, msg: error });
        res.json({ results });
      }
    );
  },
};

module.exports = functions;
