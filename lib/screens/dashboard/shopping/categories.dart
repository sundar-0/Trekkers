import 'package:flutter/material.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';

class Categories extends StatefulWidget {
  final Function toggle;
  const Categories(this.toggle, {Key? key}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  
  String ? token;
  final AuthController authController=Get.find();
  var categories=[]; 
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      token=authController.login.value.token;
    });
    fetchAllCategories();
  }   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index,categories[index]['_id'],categories[index]['category_name']),
        ),
      ),
    );
  }
  Widget buildCategory(int index,String catId,String catName) {
    return GestureDetector(
      onTap: () {
        widget.toggle(catName,catId);
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              catName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
    
  }

    
  Future fetchAllCategories() async{
          var header={
            "Authorization":"Bearer $token"
          };
          final response=await http.get(Uri.parse("$baseUrl/category/fetchcategory"),headers: header);
          print(response.statusCode);
          if (response.statusCode == 200) {
            final data=jsonDecode(response.body.toString()); 
            print(data);
            print(data);  
            final result=data["result"];
            setState(()  {
              categories= result;
            });

          }
          else{
            categories=[];
          }
   }

}

