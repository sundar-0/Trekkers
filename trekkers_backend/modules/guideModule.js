var mongoose=require('mongoose')
require('dotenv').config()
var dburl=process.env.MONGO_DB_URL||"mongodb+srv://sundar12:776WKX4P5q0KsI0E@cluster0.wdu8u.mongodb.net/Trekkers?retryWrites=true&w=majority"
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;

var guideDocumentSchema=new mongoose.Schema({
    photo:{type:String},
    citizenship_front:{type:String},
    citizenship_back:{type:String},
    passport:{type:String},
    academic_certificate:{type:String},
    language_certificate:{type:String}

})

var guideSchema=new mongoose.Schema({
    fname:{
        type:String,
    },
    lname:{
        type:String
    },
    email:{
        type:String,
        required:true,
        index:{
            unique:true
        },
        match:/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    review:{
        type:String
    },
    phone:{
        type:String,    
    },
    password:{
        type:String,
        required:true
    },
    communication_skill:{
        type:String
    },
    known_languages:{
        type:Array
    },
    documents:{
        type:guideDocumentSchema
    }
})
var guideModel=mongoose.model('guides',guideSchema)
module.exports=guideModel

