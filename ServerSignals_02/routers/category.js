const Categories = require("../models/Category")

const router_category = (app) => {

    app.get("/category", (req,res) => {
        res.render("master_views", {content: "./category/category"})
    });

    app.get("/test", (req,res) => {
        res.render("master_views", {content: "./category/test"})
    });

    app.post("/Cate/Add", (req,res) => {
        const newName = req.body.name;
        const newImgName = req.body.imgName;
        const newCate = Categories({
            name: newName,
            imageName: newImgName
        });
        newCate.save((err,dataNewCate) => {
            if(err) {
                res.json({result: 0, messenger: err})
            } else {
                res.json({result: 1, messenger: "Upload Succesfully", newCate: dataNewCate})
            }
        });
    });

    app.post("/Cate/findAll", (req,res) => {
        Categories.find((err,dataListCate) => {
            if(err) {
                res.json({result: 0, messenger: err});
            } else {
                res.json({result: 1, messenger: dataListCate});
            }
        });
    });

    app.post("/Cate/Edit", (req,res) => {
        const id = req.body.idCate
        const name = req.body.nameCate
        const imgName = req.body.imgNameCate

        Categories.findByIdAndUpdate(id, { name:name, imageName: imgName }, (err, dataCateUpdate) => {
            if(err) {
                console.log("Loi!",err)
                res.json({result: 0, messenger: err});
            } else {
                console.log(dataCateUpdate)
                res.json({result: 1, messenger: dataCateUpdate});
            }
        })
    });

    app.post("/Cate/Delete", (req,res) => {
        const id = req.body.idCate

        Categories.findByIdAndDelete(id, (err) => {
            if(err) {
                res.json({result: 0, messenger: err});
            } else {
                res.json({result: 1, messenger: "Delete Succesfully!"});
            }
        })
    });
}
module.exports = router_category;