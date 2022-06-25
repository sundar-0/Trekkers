var guideModule=require('../../modules/guideModule')
exports.uploadDocs=async(req,res,next)=>{
    console.log('file:',req.files);
    var id=req.params.gid;
    var documents=req.files;
    console.log(id);
    guideModule.findOneAndUpdate({_id:id},{$set:{
        documents:{
                photo:documents[0].path, 
                citizenship_front:documents[1].path,
                citizenship_back:documents[2].path,
                passport:documents[3].path,
                academic_certificate:documents[4].path,
                language_certificate:documents[5].path

        }}},
        {
            returnNewDocument:true
        }  
    )
    .then(data=>{
        res.json({
            'message':'Document Uploaded Successfully',
            'result':data
        })
    })
}
exports.fetchDocs=(req,res,next)=>{
   var id=req.params.gid
   guideModule.find({_id:id})
   .exec()
   .then((data)=>{
       res.status(200).json({
       'message':'success',
       'result':data[0].documents
       })
   })
//    userImageModule.find({userid:id})
//    .exec()
//    .then((data)=>{
//        res.status(200).json({
//        'message':'success',
//        'result':data
//        })
//    })
}










