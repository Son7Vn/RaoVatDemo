const mongoose = require("mongoose");
const tokensSchema = new mongoose.Schema({
    username: String,
    admin: Boolean,
    status: Boolean,
    token: String,
    Date: Date
});
module.exports = mongoose.model("Tokens", tokensSchema);