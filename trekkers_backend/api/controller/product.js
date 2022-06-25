var productModule=require('../../modules/productModule')
var bcrypt=require('bcrypt')
var jwt=require('jsonwebtoken')
require('dotenv').config()
var secretKey=process.env.SECRET_KEY

exports.fetchProductsByCategory=(req,res,next)=>{
    var cat_id=req.params.cat_id;
    productModule.find({category:cat_id})
    .exec()
    .then((data)=>{
        res.status(200).json({
            'message':'success',
            'result':data
        })
    })
}

exports.fetchSingleProduct=(req,res,next)=>{
    var prod_id=req.params.prod_id;
    productModule.find({})
    .where('_id',prod_id)
    .exec()
    .then((data)=>{
        res.status(200).json({
            'message':'success',
            'result':data
        })
    })
}