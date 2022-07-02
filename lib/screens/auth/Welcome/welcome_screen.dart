import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/screens/dashboard/dashboard.dart';
import 'components/body/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
   
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => WelcomeScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.put(AuthController());
    return 
     const Scaffold(
      body: Body(),
    );
  }
}
