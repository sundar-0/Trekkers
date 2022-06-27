var mongoose=require('mongoose')
require('dotenv').config()||"mongodb+srv://sundar12:776WKX4P5q0KsI0E@cluster0.wdu8u.mongodb.net/Trekkers?retryWrites=true&w=majority"
var dburl=process.env.MONGO_DB_URL
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var eventSchema=new mongoose.Schema({
   event_creator:{type:mongoose.Schema.Types.ObjectId,ref:'users',required:true},
   event_date:{type:Date},
   event_time:{type:String},
   places_going:{type:Array},
   users_going:{type:Array},
   estimated_day:{type:Number},
})
var eventModel=mongoose.model('events',eventSchema)
module.exports=eventModel

