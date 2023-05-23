require("dotenv").config();
const mysql = require("mysql");

const dbConfig = {
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
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
