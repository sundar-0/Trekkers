import 'package:flutter/material.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/models/product.dart';
import 'package:trekkers_project/screens/dashboard/product_details/details_screen.dart';
import 'package:trekkers_project/screens/dashboard/shopping/categories.dart';
import 'item_card.dart';
class Body extends StatefulWidget {
  
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String cat_name="Trek bag";
  void changeCategory(String catName){
    setState(() {
      cat_name=catName;
   
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(changeCategory),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child:customWidget(cat_name)
          )
        ),
      ],
    );
  }
}
Widget customWidget(String? catName)=> catName=="Trek bag"?
GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
    
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>DetailsScreen(product:products[index]  )
                          )),
                    ))
                    :
                    Text(catName!);