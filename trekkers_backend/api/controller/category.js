var categoryModule=require('../../modules/categoryModule')
var bcrypt=require('bcrypt')
var jwt=require('jsonwebtoken')
require('dotenv').config()
var secretKey=process.env.SECRET_KEY
exports.fetchCategory=(req,res,next)=>{
categoryModule.find({})
.exec()
.then((data)=>{
    res.status(200).json({
    'message':'success',
    'result':data
    })
})
}
exports.AddCategory=(req,res,next)=>{
    var catName=req.body.catName;
    var category=new categoryModule({
        category_name:catName
        })
    category.save()
        .then(data=>{
            res.json({
                message:"category Added SuccessFully",
                data:data
            })
    })
}