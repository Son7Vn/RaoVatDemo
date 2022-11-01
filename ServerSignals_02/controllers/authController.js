const User = require("../models/users");
const Tokens = require("../models/Tokens");
const bcrypt = require("bcrypt");
const multer = require("multer")
// const { response } = require("express");
const jwt = require("jsonwebtoken");

const privateKey = "privateKey7";

const authenController = {
    //Register:
    registerUser: async(req,res) => {
    try {
        if (!req.body.username || !req.body.password || !req.body.email || !req.body.avatar) {
            res.json({result: 0, messenger: "Please valid all information!"});
        } else {
            User.find({
                "$or": [{ username: req.body.username }, { email: req.body.email }]
            }, (err, dataVerifyUserOrEmail) => {
                if(err) {
                    res.json({result: 0, messenger: "Error find from Server", err: err});
                } else if (dataVerifyUserOrEmail.length > 0 ) {
                    res.json({result: 0, messenger: "Username or Email already used!"});
                } else if (dataVerifyUserOrEmail.length == 0) {
                    bcrypt.genSalt(10, (err, salt) => {
                        bcrypt.hash(req.body.password, salt, (err, hash) => {
                            if (err) {
                                res.json({result: 0, messenger: "Failed to Encode password with bcrypt!", err: err});
                            } else {
                                const newUser = new User({
                                    username: req.body.username,
                                    password: hash,
                                    admin: req.body.admin,
                                    email: req.body.email,
                                    avatar: req.body.avatar,
                                    status: 0,
                                    Date: Date.now()
                                });
                                newUser.save((err, newUserData) => {
                                    if(err) {
                                        res.json({result: 0, messenger: "Error to save new User", err: err});
                                    } else {
                                        const {password, ...others} = newUserData._doc 
                                        res.json({result: 1, messenger: "Succesfully to create new User!", newUser: {...others}});
                                    }
                                });
                            }
                        });
                    });
                }
            });
        }
        }catch(err) {
            res.json({result: 0, messenger: "Error Register!", err: err});
        } 
    },
    //Login
    loginUser: async(req,res) => {
        try{
            if (!req.body.username || !req.body.password){
                res.json({result: 0, messenger: "Please valid username,password!"});
            } else {
                User.findOne({username: req.body.username}, (err,dataUser) => {
                    if(err) {
                        res.json({result: 0, messenger: "Error find on Mongoose", err: err});
                    } else if (dataUser == null) {
                        res.json({result: 0, messenger: "Wrong username!"});
                    } else {
                        bcrypt.compare(req.body.password, dataUser.password, (err,respone) => {
                            if (!err && respone === true) {
                                //jwt
                                const {password, ...others} = dataUser._doc;
                                const dataPayload = {...others}
                            
                                const accessToken = authenController.generateAccessToken(dataPayload);
                                const refreshToken = authenController.generateRefreshToken(dataPayload);
                                
                                const savedRefreshToken = new Tokens({
                                    username: dataUser.username,
                                    admin: dataUser.admin,
                                    status: true,
                                    token: refreshToken,
                                    Date: Date.now()
                                });
                                savedRefreshToken.save((err,tokenSavedData) => {
                                    if (err) {
                                        res.json({result: 0, messenger: "Errror saved RefreshToken", err: err});
                                    } else {
                                        res.cookie("refreshToken",refreshToken, {
                                            httpOnly: true,
                                            secure: false,
                                            path: "/",
                                            sameSite: "strict",
                                        });
                                        res.json({result: 1, messenger: "Succesfully get token & saved RefreshToken", token: accessToken});
                                    }
                                });
                            } else {
                                res.json({result: 0, messenger: "Errror!", err: err});
                            }
                            
                        });
                    }
                });
            }
        }catch(err) {
            console.log("Loi o day: ",err)
            res.json({result: 0, messenger: "Error!", err: err});
        }
    },
    //generate AccessToken
    generateAccessToken:  (dataPayload) => {   
        return jwt.sign(dataPayload,privateKey, {expiresIn: 12000});
    },
    // generate RefreshToken
    generateRefreshToken: (dataPayload) => {
        return jwt.sign(dataPayload,privateKey, {expiresIn: "7d"});
    },
    //reset access and refresh Token
    requestRefreshToken: async (req,res) => {
        try {
            const RFToken = await req.cookies.refreshToken
            Tokens.findOne({token: RFToken}, (err, rftokenData) => {
                if (err) {
                    res.json({result: 0, messenger: "Error RFToken from MongoDB!", err: err});
                } else if (!rftokenData) {
                    res.json({result: 0, messenger: "Token is not valid"});
                } else if (rftokenData) {
                    jwt.verify(RFToken, privateKey, (err, decoded) => {
                        if (err) {
                            res.json({result: 0, messenger: "Error to verify RFToken", err: err});
                        } else {
                            Tokens.findOneAndDelete({token: RFToken},(err) => {
                                if(err) {
                                    console.log("delete err", err)
                                    res.json({result: 0, messenger: "Failed to delete token",err: err});
                                } else {
                                    console.log("Ok")
                                }
                            });
                            const payload = {
                                username: decoded.username,
                                admin: decoded.admin,
                                email: decoded.email,
                                avatar: decoded.avatar,
                                Date: Date.now()
                            }
                            const newAccessToken = authenController.generateAccessToken(payload);
                            const newRefreshToken = authenController.generateRefreshToken(payload);
                            const SaveNewRefreshToken = new Tokens({
                                username: decoded.username,
                                admin: decoded.admin,
                                status: true,
                                token: newRefreshToken,
                                Date: payload.Date
                            });
                            SaveNewRefreshToken.save((err,dataNewRFToken) => {
                                if (err) {
                                    res.json({result: 0, messenger: "Failed to save newRFToken",err: err});
                                } else {
                                    
                                    res.cookie("refreshToken",dataNewRFToken.token, {
                                        httpOnly: true,
                                        secure: false,
                                        path: "/",
                                        sameSite: "strict",
                                    });
                                    res.json({result: 1, messenger: "Succesfully get token & saved newRefreshToken", newAccessToken: newAccessToken});
                                }
                            });
                        }
                    });
                } 
            });
            
        } catch(err) {
            console.log(err)
            res.json({result: 500, messenger: "ERROR!",ERROR: err});
        }
    },
    //logout
    logout: async (req,res) => {
        try {
            await Tokens.findOneAndDelete({token: req.cookies.refreshToken});
            return res.json({result: 1, messenger: "Logout Successfully!"});
        } catch(err) {
            return res.json({result: 0, messenger: "Error to logout!", err: err});
        }
    },
    testUploadImage: async(req,res) => {
        try{
            const storage = multer.diskStorage({
                destination: function (req, file, cb) {
                  cb(null, "public/upload")
                },
                filename: function (req, file, cb) {
                  const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
                  cb(null, file.fieldname + '-' + uniqueSuffix + file.originalname)
                }
            });
            
            const upload = multer(
                { storage: storage,
                fileFilter: function fileFilter (req, file, cb) {
                    if (file.mimetype == "image/png" ||
                        file.mimetype == "image/gif" ||
                        file.mimetype == "image/jpg" ||
                        file.mimetype == "image/jpe" ||
                        file.mimetype == "image/jpeg"
                    ) {
                        cb(null, true)
                    } else {
                        cb(new Error('I don\'t have a clueee!'))
                    }
                }
                }
            ).single("avatar");

            upload(req, res, function (err) {
                if (err instanceof multer.MulterError) {
                    setTimeout(() => {
                        res.json({result: 0, messenger: "Error upload image fr Multer", loi: err});
                    }, 3000);
                  
                } else if (err) {
                    setTimeout(() => {
                        res.json({result: 0, messenger: "Error upload image normal err", loi: err});
                    }, 3000);
                    
                }
                setTimeout(() => {
                    res.json({result: 1, messenger: "Ok", file: req.file.filename});
                }, 3000);
                
            })

        } catch(err) {
            console.log(err)
            res.json({result: 0, messenger: "Error upload image", loi: err});
        }
    }
}

module.exports = authenController;
