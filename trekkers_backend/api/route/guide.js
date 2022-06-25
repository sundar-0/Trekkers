var express = require('express');
var router = express.Router();
var checkAuth=require('../middleware/auth')
var guideController=require('../controller/guide')
router.get('/fetchguide',checkAuth,guideController.fetchGuide)
router.post('/addguide',guideController.addGuide)
router.delete('/deleteguide/:id',checkAuth,guideController.deleteGuide)
// router.put('/updateguide/:id',checkAuth,guideController.updateGuide)
router.post('/login',guideController.guideLogin)

module.exports=router;