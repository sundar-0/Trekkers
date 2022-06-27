var mongoose=require('mongoose')
require('dotenv').config()
var dburl=process.env.MONGO_DB_URL||"mongodb+srv://sundar12:776WKX4P5q0KsI0E@cluster0.wdu8u.mongodb.net/Trekkers?retryWrites=true&w=majority"
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var userSchema=new mongoose.Schema({
    email:{
        type:String,
        required:true,
        index:{
            unique:true
        },
        match:/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    password:{
        type:String,
        required:true
    },
    phone:{
        type:String,
        required:true,
      
    },
    date_joined:{
        type:Date,
        default:Date.now
    },
    user_profile_url:{
        type:String,
        default:""
     
    }
})
var userModel=mongoose.model('users',userSchema)
module.exports=userModel

