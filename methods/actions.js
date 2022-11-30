var User= require('../model/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')


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
    }
}
module.exports = functions