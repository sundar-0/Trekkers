import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:trekkers_project/data/models/login.dart';
import 'package:trekkers_project/data/models/signup.dart';
import 'package:trekkers_project/data/services/auth.dart';
class AuthController extends GetxController{
var login=Login().obs;
var signup=Signup().obs;
AuthService authService=AuthService();

//login user
Future loginUser(String email,String password) async{
var result =await authService.userLogin(email, password);
login.value=result;
}

//signup user
Future signupUser(String email,String password,String phone) async{
  var result=await authService.userSignUp(email, password, phone);
  signup.value=result;
}


}
