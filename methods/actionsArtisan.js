var Artisan= require('../model/artisan')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')
const { authenticate, use } = require('passport')


var functions = {
    addNew : function(req,res) {
        res.json(req.body.name,req.body.password,req.body.username,req.body.telephone,req.body.mail,req.body.siret,req.body.mobilite)
        if((!req.body.name) || (!req.body.password) || (!req.body.username) || (!req.body.telephone)||(!req.body.mail) || (!req.body.siret)||(!req.body.mobilite) ||(!req.body.adress) ||(!req.body.domaine)||(!req.body.entreprise)) {
            res.json({success:false,msg:"Remplisez tout artistans "})
        }
        else{
            var newArtisan= Artisan({
                name:req.body.name,
                password:req.body.password,
                username:req.body.username,
                telephone:req.body.telephone,
                email:req.body.mail,
                siret:req.body.siret,
                mobilite:req.body.mobilite,
                adress:req.body.adress,
                domaine:req.body.domaine,
                entreprise:req.body.entreprise,
                picture:req.body.picture,
                note:req.body.note,
                chantier:req.body.chantier,
            })
            newArtisan.save(function(err,newArtisan){
                if(err){
                    res.json({success:false,msg:"sauvegarde raté artisans"})
                }else {
                     res.json({success:true,msg:"sauvegarde réussi artisans"})
                }
            })
        }
    },
    authenticate: function(req,res){
        Artisan.findOne({
            email: req.body.email
        }, function(err,artisan){
            if(err) throw err
            if(!artisan) {
                res.status(403).send({success:false,msg:'Authenticate failed, User not found'})
            }
            else {
                artisan.comparePassword(req.body.password, function(err,isMatch){
                    if(isMatch && !err) {
                        var token = jwt.encode(artisan,config.secret)
                        res.json({success:true,token:token})
                    }
                    else{
                        return res.status(403).send({success:false,msg:'Authenticate failed, Wrong password'})
                    }
                })
            }
        }
        )
    },
    getInfo: function(req,res){
        if(req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer'){
            var token = req.headers.authorization.split(' ')[1]
            var decodedToken = jwt.decode(token,config.secret) 
            return res.json({success : true , msg : "hello " + decodedToken.name + " mdp : " + decodedToken.password})
        }else {
            return res.json({success:false, msg:'No Headers'})
        }
    }
}
module.exports = functions