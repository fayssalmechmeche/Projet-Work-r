const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const connectDB = require("./js/config/db");
const passport = require("passport");
const bodyParser = require("body-parser");
const routes = require("./js/config/index");

const app = express();

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(routes);
app.use(passport.initialize());
require("./js/config/passport")(passport);

const PORT = process.env.PORT || 3000;

app.listen(
  PORT,
  console.log(`Server Running in ${process.env.NODE_ENV} mode on port ${PORT}`)
);
