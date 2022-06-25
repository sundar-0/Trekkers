var mongoose=require('mongoose')
require('dotenv').config()
var dburl=process.env.MONGO_DB_URL
mongoose.connect(dburl,{useNewUrlParser:true,useCreateIndex:true, useUnifiedTopology: true })
var conn=mongoose.Collection;
var userPostSchema=new mongoose.Schema({
    user:{type:mongoose.Schema.Types.ObjectId,ref:'users',required:true},
    post:{type:String},
    video_url: {
        type:Array
    },
    image_url:{
        type:Array
    },
    created_on:{
        type:Date,
        default:Date.now
    },
})
var userPostModel=mongoose.model('user_posts',userPostSchema)
module.exports=userPostModel

