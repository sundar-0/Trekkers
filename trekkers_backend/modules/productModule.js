

var mongoose=require('mongoose')
require('dotenv').config()
var dburl=process.env.MONGO_DB_URL||"mongodb+srv://sundar12:776WKX4P5q0KsI0E@cluster0.wdu8u.mongodb.net/Trekkers?retryWrites=true&w=majority"
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var productSchema=new mongoose.Schema({
   product_name:{type:String},
   size:{type:Array},
   product_image:{type:String},
   price:{type:Object},
   seller_info:{type:mongoose.Schema.Types.ObjectId,ref:'seller'},
   category:{type:mongoose.Schema.Types.ObjectId,ref:'categories',required:true},
})
var productModel=mongoose.model('products',productSchema)
module.exports=productModel

