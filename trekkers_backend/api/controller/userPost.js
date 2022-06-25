

var userPostModule=require('../../modules/userPostModule') 
var userModule=require('../../modules/userModule')
const cloudinary=require('cloudinary')
require('../../utils/cloudinary')
var path = require('path')
var images=[]
var videos=[]
async function uploadMedia(filename,filepath) {

	let ext=path.extname(filename).split(".").pop()
	if(ext==="jpeg"||ext==="png"||ext==="jpg"){
		const result=cloudinary.v2.uploader.upload(filepath,{ resource_type: "image",  public_id: `ImageUploads/${filename.split(".")[0]}`})
	   console.log((await result).secure_url)
		images.push((await result).secure_url)	
	}
	else if(ext==="mp4"||ext==="mov"||ext==="mkv"){
		const result=cloudinary.v2.uploader.upload(filepath,{ resource_type: "video",  public_id: `videoUploads/${filename.split(".")[0]}`})
		console.log((await result).secure_url)
		videos.push((await result).secure_url)
	}
}

exports.createPost=async(req,res,next)=>{
	images=[]
	videos=[]
    var userId=req.params.uid;
    var userPost=req.body.userPost;
	var medias=req.files;
	console.log(medias);
	if(medias!==undefined){
	for(var i=0;i<medias.length;i++){
		await uploadMedia( medias[i].filename,medias[i].path)
	}
	console.log(images)
	console.log(videos)
}
	// medias.forEach(async function (media,index){
	// 	var ext=path.extname(media.filename).split('.').pop();
	// 	if(ext==="jpeg"||ext==="png"||ext==="jpg"){
 	// 	const result=cloudinary.v2.uploader.upload(medias[index].path,{ resource_type: "image",  public_id: `ImageUploads/${media.filename}`})
	// 	console.log((await result).secure_url)
		
	// 	 images.push((await result).secure_url)	
	// 	}
	// 	else if(ext==="mp4"||ext==="mov"||ext==="mkv"){
	// 	const result=cloudinary.v2.uploader.upload(medias[index].path,{ resource_type: "video",  public_id: `videoUploads/${media.filename}`})
	// 	console.log((await result).secure_url)
	// 	 videos.push((await result).secure_url)
	// 	}
	// });

	

    var post=new userPostModule({
        user:userId,
        post:userPost, 
		video_url:videos.length!=0?videos:[],
		image_url:images.length!=0?images:[]
        // video_url:req.file.filename===null?"": (await result).secure_url,
        // image_url:""
        
    })
        post.save()
        .then(data=>{
            res.json({
                message:"Your post was created successfully",
                data:data
            })
    })
}

// db.Product.findOne({ _id: req.params.id })
// // ..and populate all of the notes associated with it
// .populate("review")
// .then(function(dbProduct) {
//   // If we were able to successfully find an Product with the given id, send it back to the client
//   res.json(dbProduct);
// })
// .catch(function(err) {
//   // If an error occurred, send it to the client
//   res.json(err);
// });
// });

// exports.fetchAllPosts=(req,res,next)=>{


// 	userPostModule.find({})
// 	.populate({ 
// 	   path: 'uid',
// 	   model:userModule,	
// 	})

// 	.exec()
// 	.then((data)=>{
// 		res.status(200).json({
// 			'message':'success',
// 			'result':data
// 			})
// 	})

// userPostModule.find({})
// .populate('uid',{'email':1})
// .populate()
// .exec()
// .then((data)=>{
// 	res.status(200).json({
// 		'message':'success',
// 		'result':data
// 		})
// })

// }
exports.fetchAllPosts=(req,res,next)=>{
userPostModule.find({})
.sort({created_on:-1})
.populate('user',{'email':1,'user_profile_url':1})
.exec()
.then((data)=>{
	res.status(200).json({
		'message':'success',
		'result':data
		})
})
 }

exports.fetchAllPostsBySingleUser=(req,res,next)=>{
var userid=req.params.uid;
userPostModule.find({user:userid})
.exec()
.then((data)=>{
    res.status(200).json({
        'message':'success',
        'result':data
    })
})

 }
exports.fetchSinglePost=function(req,res,next){
	var id=req.params.pid;
	if(id.match(/^[0-9a-f]{24}$/i)){
		userPostModule.findById(id, function (err, data) {
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







