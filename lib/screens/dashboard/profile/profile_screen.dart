import 'package:flutter/material.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/screens/dashboard/profile/body.dart';
class ProfileScreen extends StatefulWidget {

  static const String routeName = "/profile";
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => ProfileScreen(),
        settings: RouteSettings(name: routeName));
  }
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      elevation: 0,
      title: const Text('Profile',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
      body: Body(),   
    );
  }
}