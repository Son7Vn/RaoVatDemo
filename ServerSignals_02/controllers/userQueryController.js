const User = require("../models/users");

const userQuery = {
    delete: async(req,res) => {
        try{

       const userDelete = await User.findById({'_id': req.body.id});
            
       if (userDelete != null) {
        res.json({result: 1, messenger: "Delete is Ok!"});
       } else {
        res.json({result: 0, messenger: "Cant find user on DB!", err: err});
       }
    } catch(err) {
        console.log(err);
        res.json({result: 0, messenger: "Error fr server!", err: err})
    }
    },
    findAll: async (req,res) => {
        try {
            const listUser = await User.find()
            //parse toJSON
            const listUserParseJS = listUser.map(el => {
                const el1 = el.toJSON()
                return el1
            })
            // delete password attribute
            const dataNoPassword = listUserParseJS.map(user => {
                const obj = {}
                Object.entries(user).forEach(([key,val]) => {
                    if (key !== "password")
                        obj[key] = val
                })
                return obj
            })
            // console.log(user12Test)
            res.json({result: 1, messenger: "Success to find all user!", data: dataNoPassword})

        } catch(err) {
            console.log("error ne", err)
            res.json({result: 0, messenger: "Error from server!", err: err});
        }
    }
}
module.exports = userQuery;