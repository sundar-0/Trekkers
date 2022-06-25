var mongoose=require('mongoose')
require('dotenv').config()
var dburl=process.env.MONGO_DB_URL
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var categorySchema=new mongoose.Schema({
   category_name:{type:String}
})
var categoryModel=mongoose.model('categories',categorySchema)
module.exports=categoryModel

