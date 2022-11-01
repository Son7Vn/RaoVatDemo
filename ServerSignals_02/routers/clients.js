const { decode } = require("jsonwebtoken");
const authenController = require("../controllers/authController");
const authorController = require("../controllers/middleware");
const userQuery = require("../controllers/userQueryController");

const routers = (app) => {

    app.post("/register",authenController.registerUser);
    app.post("/login",authenController.loginUser);
    app.post("/verify",authorController.authorize, (req,res) => {
        res.json({result: 1, messenger: "Success to verify token!",token: req.body.token,decode: req.decode})
    });
    app.post("/refreshToken", authenController.requestRefreshToken);
    app.post("/logout",authorController.authorize,authenController.logout)
    app.post("/uploadTest",authenController.testUploadImage);

    app.post("/read",authorController.authorize,userQuery.findAll);
    app.post("/delete",authorController.authorizeAndAdminAuthor,userQuery.delete);
    
    app.post("/testRegister", (req,res) => {
        // const datatest = JSON.parse(Object.keys(request.body)[0])
        // console.log(req.body.username)
        if (!req.body.username || !req.body.password || !req.body.avatar || !req.body.email) {
            res.json({result: 0, messenger: "Need valid username, password"});
        } else {
            let json = {
                username: req.body.username,
                password: req.body.password,
                avatar: req.body.avatar,
                email: req.body.email
            }
            res.json({result: 0, messenger: "Ok",json: json});
        }
    });

    app.post("/testHeaders", (req,res) => {
        console.log(req.headers)
        res.json({result: 1, messenger: "Ok", data: req.headers})
    });

    app.get("/image", (req,res) => {
        res.send("Hello")
    })
}

module.exports = routers;