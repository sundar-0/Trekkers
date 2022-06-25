var express = require('express');
var router = express.Router();
var checkAuth=require('../middleware/auth')
var productController=require('../controller/product')
router.get('/fetchproduct/:cat_id',checkAuth,productController.fetchProductsByCategory)
router.get('/fetchsingleproduct/:prod_id',checkAuth,productController.fetchSingleProduct)
// router.get('/fetchevent/:eventid',checkAuth,eventController.fetchSingleEvent)
// router.post('/addproduct',productController.addEvent)

module.exports=router;