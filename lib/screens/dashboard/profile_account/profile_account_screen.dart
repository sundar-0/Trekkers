import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/screens/dashboard/profile/body.dart';

class ProfileAccountScreen extends StatefulWidget {

  static const String routeName = "/profile_account";
  String? uid;
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => ProfileAccountScreen(),
        settings: RouteSettings(name: routeName));
  }
  ProfileAccountScreen({
    Key? key,
    this.uid,
  }) : super(key: key);

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Account',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      )),
      body: Text("Profile Account:${widget.uid}"));
  }
}