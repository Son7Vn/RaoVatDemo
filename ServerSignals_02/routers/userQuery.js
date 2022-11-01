
const authorController = require("../controllers/middleware");
const userQuery = require("../controllers/userQueryController");

const rounters = require("express").Router();

// rounters.post("/delete",authorController.authorizeAndAdminAuthor,userQuery.delete);

module.exports = rounters;