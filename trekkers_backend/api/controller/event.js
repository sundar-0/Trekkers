var eventModule=require('../../modules/eventModule')
var bcrypt=require('bcrypt')
var jwt=require('jsonwebtoken')
require('dotenv').config()
var secretKey=process.env.SECRET_KEY
exports.fetchEvent=async function(req,res,next){
	// userModule.find({}).where('status','Active')
	eventModule.find({})
    .populate('event_creator',{'email':1,'user_profile_url':1})
	.exec()
	.then((data)=>{
		res.status(200).json({
		'message':'success',
		'result':data
		})
	})
}
exports.addEvent=async function(req,res,next){
    var event_creator=req.body.eventCreator
    var event_date=req.body.eventDate
    var event_time=req.body.eventTime
    var places_going=req.body.placesGoing
    var users_going=req.body.usersGoing
    var estimated_day=req.body.estimatedDay

    if(event_creator.match(/^[0-9a-f]{24}$/i)){
    var event=new eventModule({
    event_creator:event_creator,
    event_date:event_date,
    event_time:event_time,
    places_going:places_going,
    users_going:users_going,
    estimated_day:estimated_day
    })
    event.save()
        .then(data=>{
            res.json({
                message:"Your event was created successfully",
                data:data
            })
    })
}

}

