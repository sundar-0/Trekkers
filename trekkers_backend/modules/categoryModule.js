var mongoose=require('mongoose')
require('dotenv').config()||"mongodb+srv://sundar12:776WKX4P5q0KsI0E@cluster0.wdu8u.mongodb.net/Trekkers?retryWrites=true&w=majority"
var dburl=process.env.MONGO_DB_URL
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var categorySchema=new mongoose.Schema({
   category_name:{type:String}
})
var categoryModel=mongoose.model('categories',categorySchema)
module.exports=categoryModel

