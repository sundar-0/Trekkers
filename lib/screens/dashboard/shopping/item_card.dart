import 'package:flutter/material.dart';

import 'package:trekkers_project/constants/constants.dart';
class ItemCard extends StatelessWidget {
  final Function press;
  final String productId,productName,productImage,sellerInfo;
  final List sizeAvailable;
  final Map productPrice;

  const ItemCard({
    Key ?key,
    required this.press,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.sellerInfo,
    required this.sizeAvailable,
    required this.productPrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productPrice);
    return GestureDetector(
      onTap:()=>press(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: productId,
                child: Image.network(productImage),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              productName,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "Size Available:",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
          height: 60,
          child: ListView.builder(
            itemCount: sizeAvailable.length, 
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(4),
                      width: 80,
                      height:60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200
                        ),
                        child: Center(child: Text("${sizeAvailable[index]}\n${productPrice[sizeAvailable[index]]}",style: TextStyle(fontWeight: FontWeight.w700))));
            }),
        )
        ],
      ),
    );
  }
}
