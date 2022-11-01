const mongoose = require("mongoose");
const categorySchema = new mongoose.Schema({
    name: String,
    imageName: String
});
module.exports = mongoose.model("Categories", categorySchema);