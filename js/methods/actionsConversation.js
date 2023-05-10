var jwt = require("jwt-simple");
var config = require("../config/dbConfig");
const { authenticate, use } = require("passport");
const mysqlConnection = require("../config/db");
const bcrypt = require("bcrypt");

var functions = {
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
};

module.exports = functions;
