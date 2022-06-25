import 'package:flutter/material.dart';
class AddScreen extends StatelessWidget {
    static const String routeName = '/guide';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => AddScreen(),
        settings: RouteSettings(name: routeName));
  }
  const AddScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
   
      children: [
        Expanded(child: Container(child:Text("View Image"),color: Colors.amber.shade600,width: MediaQuery.of(context).size.width,)),
        Expanded(child: Container(child:Text("Choose Image"),color: Colors.blue.shade700,width: MediaQuery.of(context).size.width,),)
      ],
    );
  }
}