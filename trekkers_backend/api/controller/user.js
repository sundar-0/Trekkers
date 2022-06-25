var userModule=require('../../modules/userModule')
var bcrypt=require('bcrypt')
var jwt=require('jsonwebtoken')
var mongoose = require('mongoose');
require('dotenv').config()
var secretKey=process.env.SECRET_KEY
const cloudinary=require('cloudinary')
require('../../utils/cloudinary')
var path = require('path')

exports.uploadProfileImage=async function(req,res,next){
var id=req.params.uid;
var profile_image=req.file
const result=cloudinary.v2.uploader.upload(profile_image.path);
userModule.findOneAndUpdate({_id:id},{$set:{user_profile_url:profile_image!==undefined?(await result).secure_url:""},    
	returnNewDocument:true
}  )
.then(data=>{
	res.json({
		'message':'Profile Pic Uploaded Successfully',
		'result':data
	})
})
}
exports.fetchProfileImage=async function(req,res,next){
var userid=req.params.uid;
userModule.find({}).where('_id',userid)
.select('user_profile_url')
.exec()
.then((data)=>{
	res.status(200).json({
		'message':'success',
		'result':data
		})
})
}
exports.fetchUser=function(req,res,next){
	// userModule.find({}).where('status','Active')
	userModule.find({})
	.exec()
	.then((data)=>{
		res.status(200).json({
		'message':'success',
		'result':data
		})
	})
}
exports.fetchSingleUser=function(req,res,next){
	var id=req.params.id;
	if(id.match(/^[0-9a-f]{24}$/i)){
		userModule.findById(id, function (err, data) {
			if (err){
				res.status(404).json({
					'message':err
				})
			}
			else{
				res.status(200).json({
					'message':'success',
					'result':data
					})
			}
		})

	}
}
	



exports.addUser=function(req,res,next){

	email=req.body.userEmail
	password=req.body.userPassword
    phone=req.body.userPhone


	if(email===''||password===''||phone===''){
		res.json({
			'message':'All Fields Are Mandatory!!!'
		})
	}

	else{
		bcrypt.hash(password,10,function(err,hash){
			if(err) return res.json({
				message:'something wrong!!',
			    error:err
		})
			else
			{	
			var user=new userModule({
					email:email,
					password:hash,
					phone:phone
				})
			 user.save()
			.then(data=>{
			res.json({
			'message':'User Registered Successfully',
			'result':data
				})
				})
			.catch(err=>{
			res.json(err)
				})
			}
		})
}
}
exports.deleteUser=function(req,res,next){
    var id=req.params.id;
    userModule.findByIdAndDelete({_id:id})
    .then(data=>{
        res.json({
            'message':'user Deleted Successfully',
            'result':data
        })
    })
}
exports.userLogin=function(req,res,next){
	email=req.body.userEmail
	password=req.body.userPassword
	userModule.find({email:email})
	.exec()
	.then(user=>{
		if(user.length<1){
			res.json({
				message:"Authentication failed",
				token:null
			})
		}
		else{
			bcrypt.compare(req.body.userPassword, user[0].password, function(err, result) {
				if(err)
				res.json({
					message:"Authentication failed"
				})
				if(result){
					var token=jwt.sign({userid:user[0]._id},secretKey,{expiresIn:'1h'})
					res.status(201).json({
						message:"user found",
						token:token,

					})
				}
				else{
					res.json({
						message:"Authentication failed",
						token:null
					})
				}
			});
	}
	})
	.catch(err=>{
		res.json({
			error:err
		})
	})
}

exports.updateUser=function(req,res,next){
    id=req.params.id,
	email=req.body.userEmail,
    phone=req.body.userPhone,

    userModule.findOneAndUpdate({_id:id},{$set:{email:email,phone:phone}})
        .then(data=>{
            res.json({
                'message':'User Updated Successfully',
                'result':data
            })
        })
    
}