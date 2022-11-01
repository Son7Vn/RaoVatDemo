const Tokens = require("../models/Tokens");
const jwt = require("jsonwebtoken");
const privateKey = "privateKey7";

const authorController = {
    authorize: (req,res,next) => {
            if (!req.body.token) {
                res.json({result: 0, messenger: "Valid token first!"});
            } else {
                jwt.verify(req.body.token, privateKey, (err,decode) => {
                    if(err) {
                        res.json({result: 0, messenger: "Error verify token", err: err});
                    } else {
                        req.decode = decode;
                        next();
                    }
                });
            }
    },
    authorizeAndAdminAuthor: (req,res,next) => {

        authorController.authorize(req,res, () => {
            if (req.decode._id == req.body.id || req.decode.admin == true ) {
                next();
            } else {
                res.json({result: 0, messenger: "You're not permitssion!"});
            }
        });
    }
}

module.exports = authorController;