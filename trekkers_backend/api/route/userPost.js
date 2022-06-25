var express = require('express');
var router = express.Router();
var multer=require('multer')
var checkAuth=require('../middleware/auth')
var userPostController=require('../controller/userPost')
var path = require('path')
var storage = multer.diskStorage({
    filename: function (req, file, cb) {
      cb(null, Date.now()+path.extname(file.originalname))
    }
  })
  const fileFilter=(req,file,cb)=>{
    if(file.mimetype==='video/mp4'||file.mimetype==='video/mkv'||file.mimetype==='image/png'||file.mimetype==='image/jpg'||file.mimetype==='image/jpeg')
    {
        cb(null,true)
    }
    else
    {
        cb(null,false)
    }
  }
var upload = multer({ storage:storage,  
    limits:{
    fileSize:1024*1024*20
        },
fileFilter:fileFilter
     })
router.post('/:uid/createpost',upload.array('medias',10),checkAuth,userPostController.createPost)
router.get('/getAllpost',checkAuth,userPostController.fetchAllPosts)
router.get('/:uid/getAllpost/',checkAuth,userPostController.fetchAllPostsBySingleUser)
router.get('/getpost/:pid',checkAuth,userPostController.fetchSinglePost)

module.exports=router;