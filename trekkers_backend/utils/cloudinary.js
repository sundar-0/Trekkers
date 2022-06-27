const cloudinary=require('cloudinary')
cloudinary.config({
cloud_name:process.env.CLOUD_NAME||"trekkers",
api_key:process.env.API_KEY||"163861366173299",
api_secret:process.env.API_SECRET||"OD8IUxoVe1hp6dIhCnDHYQLwit4"
}
)