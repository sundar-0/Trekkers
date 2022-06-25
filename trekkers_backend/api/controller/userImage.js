var userImageModule=require('../../modules/userImageModule')
const cloudinary=require('cloudinary')
require('../../utils/cloudinary')
exports.uploadImage=async(req,res,next)=>{
    // res.send('add product post method is working')
    //console.log('file:',req.file);
    var userId=req.params.uid;
    const result=cloudinary.v2.uploader.upload(req.file.path);
    var image=new userImageModule({
        userid:userId,
        image_name:req.file.filename,
        image_url:(await result).secure_url
    })
        image.save()
        .then(data=>{
            res.json({
                message:"Profile Pic Uploaded successfully",
                data:data
            })
    })
}

// exports.uploadImage=async(req,res,next)=>{
//     // res.send('add product post method is working')
//     console.log('file:',req.file);
//     id=req.params.uid;
//     // const result=cloudinary.v2.uploader.upload(req.file.path);
//     var image=new userImageModule({
//         userid:id,
//         image_name:req.file.filename,
//         image_url:'uploads/'+req.file.filename
//     })
//         image.save()
//         .then(data=>{
//             res.json({
//                 message:"Profile Pic Uploaded successfully",
//                 data:data
//             })
//     })
// }
exports.fetchProfileImage=(req,res,next)=>{
    userid=req.params.uid
    userImageModule.find({userid:userid},{_id:0,image_url:1},function(err,data){
     res.status(200).json({
         'message':'success',
         'result':data
     })
 })
 }










