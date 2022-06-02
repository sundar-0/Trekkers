import 'package:flutter/material.dart';
class GuideScreen extends StatelessWidget {
    static const String routeName = '/guide';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => GuideScreen(),
        settings: RouteSettings(name: routeName));
  }
  const GuideScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Guide Screen"));
  }
}