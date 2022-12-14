const mongoose= require('mongoose')
const dbConfig = require('./dbConfig')

const connectDB = async() =>{
    try {
        const conn = await mongoose.connect("mongodb+srv://workr:workr1234@workr.auzdikl.mongodb.net/WorkRdb?retryWrites=true&w=majority", {
            useNewUrlParser:true,
            useUnifiedTopology:true,
            
        } )
        console.log(`mongo connected: ${conn.connection.host}`)
    }
    catch(err){
        console.log(err)
        process.exit(1)

    }
}

module.exports= connectDB