import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import '../../screens.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? user_id;
  void decodeToken(String token,SecretKey secretKey){
    try {
      final jwt = JWT.verify(token, secretKey);
      final payload=jwt.payload;
     setState(() {
       user_id=payload['userid']; 
     });
      print(user_id);
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }
 
  @override
  Widget build(BuildContext context) { 
    final AuthController _authController=Get.find();
    decodeToken(_authController.token.value, SecretKey('secret'));
    return  SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(userId: user_id!,),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: ()  {
                // Navigator.of(context).pushNamed('/profile_account');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileAccountScreen(uid: user_id)),
                   );
                
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      );

  }
}