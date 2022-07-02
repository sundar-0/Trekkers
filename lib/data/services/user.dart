import 'package:http/http.dart' as http;
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/data/models/user.dart';
import 'dart:convert';
class UserService {
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

//User Signup Code Here
Future<String> addUser(String email,String password,String phone) async{
    var data={
      'userEmail':email,
      'userPassword':password,
      'userPhone':phone
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response= await http.post(Uri.parse('$baseUrl/user/adduser'),headers: options,body: jsonEncode(data));
    print(response);
    print(response.body.toString());
    var result=jsonDecode(response.body.toString());
    return result["message"];
}

Future<String> userLogin(String email,String password) async{
 var data={
      'userEmail':email,
      'userPassword':password
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
    };
  
    final response= await http.post(Uri.parse('$baseUrl/user/login'),headers: options,body: jsonEncode(data));
    var result=jsonDecode(response.body.toString());
    return result["token"]??"";
   
}


}
