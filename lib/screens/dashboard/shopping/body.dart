import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';

import 'package:trekkers_project/screens/dashboard/product_details/details_screen.dart';
import 'package:trekkers_project/screens/dashboard/shopping/categories.dart';
import 'item_card.dart';
import 'package:http/http.dart' as http;
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? token;
  String cat_name="Trek Bag";
  String cat_id="62b312ac9a50138610a89720";
  final AuthController authController=Get.find();
  var products=[];  
  @override
  void initState() {
    super.initState();
    setState(() {
      token=authController.login.value.token;
    });
    fetchProductsByCategory();
  }
  void changeCategory(String catName,String catId){
    setState(() {
      cat_name=catName;
      cat_id=catId;
    });
    fetchProductsByCategory();
  }

   Future fetchProductsByCategory() async{
          var header={
            "Authorization":"Bearer $token"
          };
          final response=await http.get(Uri.parse("http://10.0.2.2:5000/api/product/fetchproduct/$cat_id"),headers: header);
          print(response.statusCode);
          if (response.statusCode == 200) {
            final data=jsonDecode(response.body.toString()); 
            print(data);
            print(data);  
            final result=data["result"];
            setState(()  {
              products= result;
            });

          }
          else{
            products=[];
          }
   }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Categories(changeCategory),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child:customWidget()
          )
        ),
      ],
    );
  }

Widget customWidget()=> GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>DetailsScreen(productId: products[index]['_id'])
                      )),
                      productId: products[index]['_id'],
                      productName:products[index]['product_name'],
                      sizeAvailable:products[index]['size'],
                      productPrice:products[index]['price'],
                      sellerInfo:products[index]['seller_info'],
                      productImage:products[index]['product_image']
                      )
);
                   
                    // ));
}