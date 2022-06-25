import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/controllers/cart_controller.dart';
import 'package:trekkers_project/data/models/product.dart';
import 'package:trekkers_project/screens/dashboard/cart_details/cart_details_screen.dart';
import 'package:trekkers_project/screens/dashboard/product_details/body.dart';

class DetailsScreen extends StatefulWidget {
  final String productId;
  const DetailsScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? token;
  var productDetails=[];
  final AuthController authController=Get.find();
   final cartController = Get.put(CartController());
  int cartLength=0;
  
  @override
  void initState() {
    super.initState();
    setState(() {
      token=authController.login.value.token;

    });
    fetchSingleProduct();
  }
  Future fetchSingleProduct() async{
          var header={
            "Authorization":"Bearer $token"
          };
          print(widget.productId);

          final response= await http.get(Uri.parse("http://10.0.2.2:5000/api/product/fetchsingleproduct/${widget.productId}"),headers: header);
          if (response.statusCode == 200) {
            final data=jsonDecode(response.body.toString()); 
            final result=data["result"];
            setState(()  {
              productDetails= result;
            });

          }
          else{
            productDetails=[];
          }
  }
 @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      // each product have a color
      appBar: buildAppBar(context),
      // body: Body(productDetails: productDetails,),
      body: ListView.builder(
        itemCount: productDetails.length,
        itemBuilder: (context,index){
          return Body(
            id:productDetails[index]['_id'],
            name:productDetails[index]['product_name'],
            sizeAvailable:productDetails[index]['size'],
            price:productDetails[index]['price'],
            image:productDetails[index]['product_image'],
            sellerInfo:productDetails[index]['seller_info'],      
          );
      })),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
          FlatButton.icon(
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
        )
      ],
      leading: IconButton(
        color: Colors.black,
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
        ),
        onPressed: () => Navigator.pop(context),
        ),
      title: const Text('Product Details',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      );
  }

 
}
