import 'package:flutter/material.dart';

import 'package:trekkers_project/constants/constants.dart';
class ProductDescription extends StatefulWidget {
  final String name;
  final String id;
  final String image;
  final List sizeAvailable;
  final String sellerInfo;
  final Map price;
  const ProductDescription({
    Key? key,
    required this.name,
    required this.id,
    required this.image,
    required this.sizeAvailable,
    required this.price,
    required this.sellerInfo
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n",  style: Theme.of(context).textTheme.headline6),
                    TextSpan(
                      text: "${widget.price[widget.sizeAvailable[0]]}\n",
                      style: Theme.of(context).textTheme.headline4
                      // copyWith(
                      //     color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: "Size\n",  style: Theme.of(context).textTheme.headline6),
                    TextSpan(
                      text: "${widget.sizeAvailable[0]}",
                      style: Theme.of(context).textTheme.headline4
                      // copyWith(
                      //     color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              SizedBox(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/2,
                child: Hero(
                  tag: "${widget.id}",
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height:2,),
          Text(widget.name,style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.green.shade400)),
          Text("Review"),
          Text(widget.sellerInfo)
        ],
      ),
    );
  }
}
