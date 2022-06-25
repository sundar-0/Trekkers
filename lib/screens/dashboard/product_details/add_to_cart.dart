import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/cart_controller.dart';


class AddToCart extends StatefulWidget {
   final String id; 
   final String image;
   final String name; 
   final String price;
   final String sizeChoosen;
   final String sellerInfo;
  const AddToCart({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.sizeChoosen,
    required this.sellerInfo
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
   
  bool isAddToCartClicked=false;
  int numOfItems = 1;
  final CartController cartController=Get.find();
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child:isAddToCartClicked==true?showCartCounter():
       FlatButton.icon(onPressed: (){
        setState(() {
          isAddToCartClicked=true;
        });  
      }, icon: Icon(Icons.shopping_cart_outlined), label: Text("Add To Cart")),
    );

  }
  Widget showCartCounter(){
 
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if(numOfItems<=1){
              setState(() {
                isAddToCartClicked=false;
              });
            }
            else{
              setState(() {
                numOfItems--;
              });
              cartController.removeCart(widget.id);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      buildOutlineButton(
              icon: Icons.add,
              press: () {
               
                setState(() {
                  numOfItems++;
                });
                cartController.addToCart( widget.id,widget.image,widget.name,widget.sizeChoosen,widget.price,numOfItems);
              }),
      ],
    );
  }
  SizedBox buildOutlineButton({IconData? icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child:OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: ()=>press(),
        child: Icon(icon),
      ),
    );
  }
}
