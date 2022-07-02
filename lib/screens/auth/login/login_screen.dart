import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/controllers/user_controller.dart';
import 'package:trekkers_project/data/models/user.dart';
import 'package:trekkers_project/data/services/auth.dart';
import 'package:trekkers_project/screens/dashboard/dashboard.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  final AuthService _authService=AuthService();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find();
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: const Text('Login',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body:
           Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                              SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    decoration:
                                        inputDecoration.copyWith(hintText: "Enter Email"),
                                    validator: (value) =>
                                        value!.isEmpty ? "please enter email" : null,
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    decoration: inputDecoration.copyWith(
                                        hintText: "Enter Password"),
                                    validator: (value) => value!.length < 6
                                        ? "password must be of 6+ chars"
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                      Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                             if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading=true;
                              });
                              await authController.loginUser(email, password);
                              
                              if(authController.token.value!=""){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen()),(route) => false);
                              }
                              setState((){isLoading=false; });                       
                          }
                        }     
                        },
                        child: const Text('Login')
                      ),
                    ),
                    isLoading?CircularProgressIndicator():Text(""),
                   
                    SizedBox(height: 30,child: Text("Don't Have Account?"),), 
                    RaisedButton(onPressed: (){
                      Navigator.of(context).pushNamed('/signup');
                    },child: Text("SignUp"),color: Colors.grey[300],)
              
                  ],
                ),
    ),
              ],
            )
          )
    );
      
    
  }




}
