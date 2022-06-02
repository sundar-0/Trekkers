import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => SignupScreen(),
        settings: RouteSettings(name: routeName));
  }
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Signup Screen");
  }
}