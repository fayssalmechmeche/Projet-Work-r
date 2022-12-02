var mongoose = require('mongoose')
var Schema = mongoose.Schema
var bcrypt = require('bcrypt')
const { use } = require('passport')
var particuliersSchema = new Schema({
    name : {
        type:String,
        require:true
    },
    password : {
        type:String,
        require:true
    },
    email : {
        type:String,
        require:true
    },
    username : {
        type:String,
        require:true
    },
    telephone : {
        type:String,
        require:true
    },
    city : {
        type:String,
        require:true
    },
    adress : {
        type:String,
        require:true
    },
    postalCode : {
        type:String,
        require:true
    },
    picture : {
        type:String,
        require:false
    },
    chantier : {
       type:String,
       require:false
    },


})
particuliersSchema.pre('save',function(next){
    var particulier = this;
    if(this.isModified('password') || this.isNew){
        bcrypt.genSalt(10,function(err,salt){
            if(err){
                return next(err)
            }
            bcrypt.hash(particulier.password,salt,function(err,hash){
                if(err){
                    return next(err)
                }
                particulier.password=hash;
                next()
            })
        })
    }
    else{
        return next()
    }
})

particuliersSchema.methods.comparePassword = function(password,cb){
    bcrypt.compare(password,this.password,function(err,isMatch){
        if(err){
            return cb(err)
        }
        cb(null,isMatch)
    })
}
,
module.exports= mongoose.model('Particulier',particuliersSchema)