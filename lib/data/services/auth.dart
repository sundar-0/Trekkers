import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trekkers_project/data/models/login.dart';
import 'package:trekkers_project/data/models/signup.dart';
import 'dart:convert';
import 'package:trekkers_project/data/models/user.dart';
import 'package:trekkers_project/screens/dashboard/dashboard.dart';

import 'package:trekkers_project/constants/constants.dart';

class AuthService{
  String? msg;
  String? token;
  

  //fetch all User
  Future<List<User>> fetchUser() async {
    final response =
        await http.get(Uri.parse('$baseUrl/user/fetchuser'));
    if (response.statusCode == 200) {
    final result=jsonDecode(response.body) as List;     
    return result.map((user) => User.fromJson(user)).toList();
    } else {
      return [];
    }
  }
//user Login Code Here
Future<Login> userLogin(String email,String password) async{
 var data={
      'userEmail':email,
      'userPassword':password
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
  
    final response= await http.post(Uri.parse('$baseUrl/user/login'),headers: options,body: jsonEncode(data));
    var raw=jsonDecode(response.body.toString());
    var result= Login.fromJson(raw);
    return result;
}

//User Signup Code Here
Future<Signup> userSignUp(String email,String password,String phone) async{
      var data={
      'userEmail':email,
      'userPassword':password,
      'userPhone':phone
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response= await http.post(Uri.parse('$baseUrl/user/adduser'),headers: options,body: jsonEncode(data));
    var raw=jsonDecode(response.body.toString());
    var result= Signup.fromJson(raw);
    return result;
}

//userLogin Code Here
Future userLogin2(String email,String password) async{
    var data={
      'userEmail':email,
      'userPassword':password
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
  
    final response= await http.post(Uri.parse('http://10.0.2.2:5000/api/user/login'),headers: options,body: jsonEncode(data));
    var result=jsonDecode(response.body.toString());
    if(response.statusCode==201){
      msg=result["message"];
      token=result["token"];
    }
    else{
      msg=result["message"];
      token=null;
  
    }
  }
//User Signup Code Here
Future userSignUp2(String email,String password,String phone) async{
      var data={
      'userEmail':email,
      'userPassword':password,
      'userPhone':phone
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response= await http.post(Uri.parse('http://10.0.2.2:5000/api/user/adduser'),headers: options,body: jsonEncode(data));
    var result=jsonDecode(response.body.toString());
      if(response.statusCode==201){
      msg=result["message"];
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen()),(route) => false);
    }
    else{
      msg=result["message"];
    }
}

}