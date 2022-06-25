import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/cart_controller.dart';
import 'package:trekkers_project/screens/dashboard/cart_details/cart_details_screen.dart';

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
    bool isSearching=false;
    var categories=[];
    final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:buildAppBar(),
       body: isSearching?SearchScreen():Body()
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      elevation: 0,
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions:<Widget> [
       Obx(()=> FlatButton.icon(
          icon:Icon(Icons.shopping_cart),
          onPressed: () {
           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>CartDetailsScreen()
                          )
           );
          },
          label: Text("${cartController.cartItem.length}"),
        )),
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
            isSearching=true;
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
          isSearching=false;
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
