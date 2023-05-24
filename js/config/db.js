require("dotenv").config();
const mysql = require("mysql");

const dbConfig = {
  host: "db4free.net",
  user: "coding",
  password: "codingfactory",
  database: "workrdb",
  connectTimeout: 20000,
};

let connection;

function handleDisconnect() {
  connection = mysql.createConnection(dbConfig);

  connection.connect(function (err) {
    if (err) {
      console.error("Error connecting to MySQL:", err);
      console.log("Retrying connection...");
      setTimeout(handleDisconnect, 2000); // Temps d'attente avant la prochaine tentative de connexion
    } else {
      console.log("Connected to MySQL database!");
    }
  });

  connection.on("error", function (err) {
    if (err.code === "PROTOCOL_CONNECTION_LOST") {
      console.error("MySQL connection lost. Reconnecting...");
      handleDisconnect();
    } else {
      throw err;
    }
  });
}

handleDisconnect();

module.exports = connection;
