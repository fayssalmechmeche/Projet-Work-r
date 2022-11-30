var User= require('../model/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')
const { authenticate, use } = require('passport')


var functions = {
    addNew : function(req,res) {
        if((!req.body.name) || (!req.body.password)) {
            res.json({success:false,msg:"Remplisez tout"})
        }
        else{
            var newUser= User({
                name:req.body.name,
                password:req.body.password
            })
            newUser.save(function(err,newUser){
                if(err){
                    res.json({success:false,msg:"sauvegarde raté"})
                }else {
                     res.json({success:true,msg:"sauvegarde réussi"})
                }
            })
        }
    },
    authenticate: function(req,res){
        User.findOne({
            name: req.body.name
        }, function(err,user){
            if(err) throw err
            if(!user) {
                res.status(403).send({success:false,msg:'Authenticate failed, User not found'})
            }
            else {
                user.comparePassword(req.body.password, function(err,isMatch){
                    if(isMatch && !err) {
                        var token = jwt.encode(user,config.secret)
                        res.json({success:true,token:token})
                    }
                    else{
                        return res.status(403).send({success:false,msg:'Authenticate failed, Wrong password'})
                    }
                })
            }
        }
        )
    }
}
module.exports = functions