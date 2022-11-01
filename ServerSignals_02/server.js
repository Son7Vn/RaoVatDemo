const express = require("express");
const app = express();
const server = require("http").Server(app);
const fs = require("fs");
const bodyParser = require("body-parser");
const cookiesParser = require("cookie-parser")

app.use(bodyParser.urlencoded({extended: false}));
app.use(cookiesParser());
//router:
// const userQerry = require("./routers/userQuery");
// app.use(userQerry);
app.use(express.static("public"));
app.set("view engine", "ejs");
app.set("views","./views")

server.listen(3000, () => { console.log("Server start port 3000! ...")});

//connect mongoose:
fs.readFile("./config.json","utf-8",(err,data)=>{
    if(err) {
        console.log("Failed to read Json file!",err);
    } else {
        let obj = JSON.parse(data);
        const mongoose = require('mongoose');
        let config = 'mongodb+srv://'+obj.mongoose.username+':'+obj.mongoose.password+'@'+obj.mongoose.server+'/'+obj.mongoose.dbname+'?retryWrites=true&w=majority'
        mongoose.connect(config, (err) => {
            if (err) {
                console.log("Error connect to mongoose!",err);
            } else {
                console.log("Succesfully to connect mongoDB!");
                //router
                require("./routers/clients")(app);
                require("./routers/master_query")(app);
                require("./routers/category")(app);
            }
        });
    }
})

