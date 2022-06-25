import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/data/services/auth.dart';
import 'package:trekkers_project/screens/auth/Signup/components/body/body.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => SignUpScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String phone="";
  String? msg;
  final AuthService _authService=AuthService();
  bool isLoading=false;

   @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find();
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: const Text('Signup',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: Obx(
        ()=> Container(
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
                                  height: 10.0,
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
                                  height: 10.0,
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
                                  height: 10.0,
                                ),
                                TextFormField(
                                  decoration: inputDecoration.copyWith(
                                      hintText: "Enter Phone Number"),
                                  validator: (value) => value!.length < 10
                                      ? "phone number must be of 10 digit"
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      phone = value;
                                    });
                                  },
                   
                                ),
                     
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                           if (_formKey.currentState!.validate()) {
                            setState(()  {
                              isLoading=true;
                            });
                            // await  _authService.userSignUp(email, password,phone);
                            // msg=_authService.msg; 
                            await authController.signupUser(email,password,phone);
                            setState((){isLoading=false; });                       
                        }
                      }     
                      },
                      child: const Text('SignUp')
                    ),
                  ),
                  isLoading?CircularProgressIndicator():Text(""),
                  authController.signup.value.message==null?Text(""):Text(authController.signup.value.message!,style: TextStyle(backgroundColor: Colors.green[400]),),
                  SizedBox(height: 10,),
                  SizedBox(height: 30,child: Text("Already Have Account?"),), 
                  RaisedButton(onPressed: (){
                    Navigator.of(context).pushNamed('/login');
                  },child: Text("SignIn"),color: Colors.grey[300],)
            
                ],
              ),
          ),
            ],
          )
        ),
      )
    );
  }
}

