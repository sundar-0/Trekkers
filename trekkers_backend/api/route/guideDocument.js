var express = require('express');
var router = express.Router();
var multer=require('multer')
var checkAuth=require('../middleware/auth')
var guideDocsController=require('../controller/guideDocs')
var storage = multer.diskStorage({
    destination:function(req,file,cb){
      cb(null,'uploads/guideDocs')
    },
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
router.post('/:gid/uploaddocs',upload.array('documents',10),guideDocsController.uploadDocs)
router.get('/:gid/fetchdocs',guideDocsController.fetchDocs)
module.exports=router;