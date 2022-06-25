import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/cart_controller.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({ Key? key }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final CartController cartController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      elevation: 0,
       leading: IconButton(
        color: Colors.black,
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
        ),
        onPressed: () => Navigator.pop(context),
        ),
      title: const Text('Choose Your Payment',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
      body:Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Rs.${cartController.totalPrice}"),
          RaisedButton(onPressed: (){
            Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>BuyWithEsewa()
                      ));
          },child: Text("Buy With Esewa",style: TextStyle(color: Colors.white),),color: Colors.green.shade800,),
          Text("OR"),
          RaisedButton(onPressed: (){},child: Text("Buy With Khalti",style: TextStyle(color: Colors.white),),color:Colors.brown.shade800)

        ],
      )),
    );
   
  }
}
class BuyWithEsewa extends StatefulWidget {
  const BuyWithEsewa({ Key? key }) : super(key: key);

  @override
  State<BuyWithEsewa> createState() => _BuyWithEsewaState();
}

class _BuyWithEsewaState extends State<BuyWithEsewa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Esewa Payment"),
      ),
      body: Center(child: Text("Buy With Esewa"),),
    ); 
  }
}
