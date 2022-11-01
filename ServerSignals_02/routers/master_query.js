const Cities = require("../models/City")
const master_routers = (app) => {

    app.get("/master", (req,res) => {
        res.render("master_views", {content: "./city/city.ejs"})
    });

    app.post("/city/add", (req,res) => {
        const newCity = new Cities({
            name: req.body.Name
        });
        newCity.save((err, cityData) => {
            if(err) {
                res.json({result: 0, Error: err});
            } else {
                console.log(cityData)
                res.json({result: 1, messenger: cityData});
            }
        });
    });

    app.post("/city/listCity", (req,res) => {
        Cities.find((err,listCity) => {
            if(err) {
                res.json({result: 0, messenger: err});
            } else {
                res.json({result: 1, messenger: listCity});
            }
        });
    });

    app.post("/city/update", (req,res) => {
        Cities.findByIdAndUpdate(req.body.id_City, {name: req.body.newName}, (err,dataUpdate) => {
            console.log(req.body.id_City)
            console.log(req.body.newName)
            console.log(dataUpdate)
            if(err) {
                res.json({result: 0, messenger: err})
            } else {
                res.json({result: 1, messenger: dataUpdate})
            }
        });
    });

    app.post("/city/delete", (req,res) => {
        Cities.findByIdAndDelete(req.body.id_City, (err) => {
            
            if(err) {
                res.json({result: 0, messenger: err})
            } else {
                res.json({result: 1, messenger: "Deleted!"})
            }
        });
    });

}

module.exports = master_routers;