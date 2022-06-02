import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
    static const String routeName = '/setting';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => SettingScreen(),
        settings: RouteSettings(name: routeName));
  }
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Setting Screen");
  }
}