import 'package:flutter/material.dart';

import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/data/models/product.dart';
import 'package:trekkers_project/screens/dashboard/product_details/add_to_cart.dart';

import 'productDescription.dart';

class Body extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final Map price;
  final List sizeAvailable;
  final String sellerInfo;
  const Body({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.sizeAvailable,
    required this.sellerInfo,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {

    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProductDescription(id: widget.id,sizeAvailable:widget.sizeAvailable,image: widget.image,name: widget.name,price:widget.price,sellerInfo: widget.sellerInfo,),
          AddToCart(id: widget.id,sizeChoosen:widget.sizeAvailable[0],image: widget.image,name: widget.name,price:widget.price[widget.sizeAvailable[0]],sellerInfo: widget.sellerInfo),
        ],
      ),
    );
  }
}
