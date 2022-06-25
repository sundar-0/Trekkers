var express = require('express');
var router = express.Router();
var checkAuth=require('../middleware/auth')
var eventController=require('../controller/event')
router.get('/fetchevent',checkAuth,eventController.fetchEvent)
// router.get('/fetchevent/:eventid',checkAuth,eventController.fetchSingleEvent)
router.post('/addevent',eventController.addEvent)

module.exports=router;