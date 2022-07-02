import 'package:get/get.dart';
import 'package:trekkers_project/data/models/user.dart';
import 'package:trekkers_project/data/services/user.dart';
class UserAuthController extends GetxController{
var user=<User>[].obs;
String msg="";
var token="".obs;
final UserService _service=UserService();
@override
  void onInit() {
    super.onInit();
    getAllUser();
    loginUser("hello@gmail.com", "hello@123");
   
   
  }
//fetch All User
Future getAllUser() async{
var result =await _service.fetchUser();
user.value=result;
}

//signup user
Future signUpUser(String email,String password,String phone) async{
  var result=await _service.addUser(email, password, phone);
  msg=result;
  print(msg);

}


//login user
Future loginUser(String email,String password) async{
var result =await _service.userLogin(email, password);
token.value=result;
print(token);
}





}
