import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
    static const String routeName = '/profile';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => ProfileScreen(),
        settings: RouteSettings(name: routeName));
  }
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}