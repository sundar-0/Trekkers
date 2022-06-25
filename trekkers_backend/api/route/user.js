var express = require('express');
var multer=require('multer')
var router = express.Router();
var checkAuth=require('../middleware/auth')
var userController=require('../controller/user')
var path = require('path')
var storage = multer.diskStorage({
    filename: function (req, file, cb) {
      cb(null, Date.now()+'.jpg')
    }
  })
  const fileFilter=(req,file,cb)=>{
    if(file.mimetype==='image/png'||file.mimetype==='image/jpg'||file.mimetype==='image/jpeg')
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
    fileSize:1024*1024*5
        },
fileFilter:fileFilter
     })
router.post('/:uid/uploadimage',upload.single('file'),checkAuth,userController.uploadProfileImage)
router.get('/:uid/fetchimage',userController.fetchProfileImage)
router.get('/fetchuser',checkAuth,userController.fetchUser)
router.get('/fetchuser/:id',userController.fetchSingleUser)
router.post('/adduser',userController.addUser)
router.delete('/deleteuser/:id',checkAuth,userController.deleteUser)
router.put('/updateuser/:id',checkAuth,userController.updateUser)
router.post('/login',userController.userLogin)

module.exports=router;