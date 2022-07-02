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
    return Column(
   
      children: [
        Expanded(child: Container(child:Text("Guide Screen"),color: Colors.amber.shade600,width: MediaQuery.of(context).size.width,)),
       
      ],
    );
  }
}