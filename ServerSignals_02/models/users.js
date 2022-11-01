const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username: String,
    password: String,
    admin: Boolean,
    email: String,
    avatar: String,
    status: Number,
    Date: Date
});

module.exports = mongoose.model("User", userSchema);