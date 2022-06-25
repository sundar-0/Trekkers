import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trekkers_project/data/models/profile.dart';
import 'dart:convert';
import 'package:trekkers_project/data/models/user.dart';
class ProfileService{

//user Profile code here
Future<Profile> userProfile(String id) async{
    final response= await http.get(Uri.parse('http://10.0.2.2:5000/api/user/login/$id'));
    
    var raw=jsonDecode(response.body.toString());
    var result= Profile.fromJson(raw);
    return result;
}
}
