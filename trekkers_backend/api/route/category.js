var express = require('express');
var router = express.Router();
var checkAuth=require('../middleware/auth')
var categoryController=require('../controller/category')
router.get('/fetchcategory',checkAuth,categoryController.fetchCategory)
router.post('/addcategory',checkAuth,categoryController.AddCategory)

module.exports=router;