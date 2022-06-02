import 'package:flutter/material.dart';
import 'package:trekkers_project/screens/dashboard/shopping/body.dart';
import 'package:trekkers_project/screens/dashboard/shopping/search_screen.dart';


class ShoppingScreen extends StatefulWidget {

    static const String routeName = '/shopping';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => ShoppingScreen(),
        settings: RouteSettings(name: routeName));
  }

 const ShoppingScreen({ Key? key }) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}


class _ShoppingScreenState extends State<ShoppingScreen> {
 Icon customIcon = Icon(Icons.search,color: Colors.black,);
 Widget customSearchBar = Text('Shopping',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800));
  final TextEditingController searchController = TextEditingController();
  bool is_searching=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:buildAppBar(),
       body: is_searching?SearchScreen():Body()
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      elevation: 0,
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
       onPressed: () {
    setState(() {
  if (customIcon.icon == Icons.search) {
     if (customIcon.icon == Icons.search) {
   customIcon = const Icon(Icons.cancel,color: Colors.teal,);
   customSearchBar = ListTile(
   leading: Icon(
    Icons.search,
    color: Colors.teal,
    size: 28,
   ),
   title:  TextField(
    controller: searchController,
    onSubmitted: (value){ 
     setState(() {
       is_searching=true;
     });
  },
    decoration: InputDecoration(
    hintText: 'Type Something...',
     hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 18,
     fontStyle: FontStyle.italic,
     
    ),
    border: InputBorder.none,
    ),
    style: TextStyle(
    color: Colors.black,
    ),
   ),
   );
  } 
    } else {
     is_searching=false;
     customIcon = const Icon(Icons.search,color: Colors.black);
     customSearchBar = Text('Shopping',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800));
    }
    });
   },
        icon: customIcon,
        ),
        
        ],
      );
  }
}
