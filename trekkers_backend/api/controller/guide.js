var guideModule=require('../../modules/guideModule')
var bcrypt=require('bcrypt')
var jwt=require('jsonwebtoken')
require('dotenv').config()
var secretKey=process.env.SECRET_KEY
exports.fetchGuide=function(req,res,next){
	// userModule.find({}).where('status','Active')
	guideModule.find({})
	.exec()
	.then((data)=>{
		res.status(200).json({
		'message':'success',
		'result':data
		})
	})
}

exports.addGuide=function(req,res,next){

	fname=req.body.fname
	lname=req.body.lname
    email=req.body.email
    phone=req.body.phone
    password=req.body.password
    review=req.body.review
    communication_skill=req.body.communication_skill
    known_languages=req.body.known_languages
	documents=req.body.documents


	if(email===''||password===''){
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
			var guide=new guideModule({
                    fname:fname,
                    lname:lname,
					email:email,
					phone:phone,
                    password:hash,
                    review:review,
                    communication_skill:communication_skill,
                    known_languages:known_languages,
					documents:documents
				})
			 guide.save()
			.then(data=>{
			res.json({
			'message':'Guide Registered Successfully',
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
exports.deleteGuide=function(req,res,next){
    var id=req.params.id;
    userModule.findByIdAndDelete({_id:id})
    .then(data=>{
        res.json({
            'message':'Guide Deleted Successfully',
            'result':data
        })
    })
}
exports.guideLogin=function(req,res,next){
	email=req.body.email
	password=req.body.password
	guideModule.find({email:email})
	.exec()
	.then(guide=>{
		if(guide.length<1){
			res.json({
				message:"Authentication failed"
			})
		}
		else{
			bcrypt.compare(req.body.password, guide[0].password, function(err, result) {
				if(err)
				res.json({
					message:"Authentication failed"
				})
				if(result){
					var token=jwt.sign({userid:guide[0]._id},secretKey,{expiresIn:'1h'})
					res.status(201).json({
						message:"guide found",
						token:token
					})
				}
				else{
					res.json({
						message:"Authentication failed"
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

// exports.updateGuide=function(req,res,next){
//     id=req.params.id,
// 	email=req.body.userEmail,
//     phone=req.body.userPhone,

//     guideModule.findOneAndUpdate({_id:id},{$set:{email:email,phone:phone}})
//         .then(data=>{
//             res.json({
//                 'message':'Guide Updated Successfully',
//                 'result':data
//             })
//         })
    
// }