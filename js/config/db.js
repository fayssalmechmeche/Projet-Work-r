// const mongoose = require("mongoose");
const dbConfig = require("./dbConfig");
var mysql = require("mysql");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "workrdb",
});

connection.connect(function () {
  console.log("Connected to MySQL database!");
});

//   try {
//     const conn = await mongoose.connect(
//       "mongodb+srv://workr:workr1234@workr.auzdikl.mongodb.net/WorkRdb?retryWrites=true&w=majority",
//       {
//         useNewUrlParser: true,
//         useUnifiedTopology: true,
//       }
//     );
//     console.log(`mongo connected: ${conn.connection.host}`);
//   } catch (err) {
//     console.log(err);
//     process.exit(1);
//   }

module.exports = connection;

// Path: js/config/dbConfig.js

// ecris moi un try catch qui permet de me connecter à ma base de donnée mysql
