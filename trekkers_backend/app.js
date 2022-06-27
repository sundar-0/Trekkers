var express = require('express');
var path = require('path');
var bodyParser=require('body-parser')
var app = express();
require('dotenv').config()
// const port=5000
/*creating Api*/
var userapi=require('./api/route/user')
var guideapi=require('./api/route/guide')
var guidedocsapi=require('./api/route/guideDocument')
var userpostsapi=require('./api/route/userPost')
var productapi=require('./api/route/product')
var eventapi=require('./api/route/event')
var categoryapi=require('./api/route/category')
app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, 'public')));
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept,Authorization"
    );
    res.header('Access-Control-Allow-Methods', 'GET,PUT,PATCH,POST,DELETE,OPTIONS');
    next();

  });


app.use('/api/user',userapi)
app.use('/api/guide',guideapi)
app.use('/api/guidedocs',guidedocsapi)
app.use('/api/userpost',userpostsapi)
app.use('/api/event',eventapi)
app.use('/api/product',productapi)
app.use('/api/category',categoryapi)
app.listen(process.env.PORT||8080,()=>{
    console.log(`server is running on 5000`);
})
module.exports = app;