import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trekkers_project/controllers/cart_controller.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({ Key? key }) : super(key: key);

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {

  @override
  Widget build(BuildContext context) {
      final CartController cartController=Get.put(CartController());
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
      title: const Text('Cart Item',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
    body:SingleChildScrollView(
      child:Obx(()=>Column(
        children:[
          SizedBox(
            height: MediaQuery.of(context).size.height-130,
            child: ListView.builder(
            itemCount:cartController.cartItem.length ,
            itemBuilder: (context,index){
              return CartDetailsTile(
                productId:cartController.cartItem[index]['product_id'],
                productImage:cartController.cartItem[index]['product_image'],
                productName:cartController.cartItem[index]['product_name'],
                sizeChoosen:cartController.cartItem[index]['size_choosen'],
                productPrice:cartController.cartItem[index]['price'],
                quantity:cartController.cartItem[index]['quantity'],
              );
            }),
          ),
        Container(
          color: Colors.blue,
          child: Row(   
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
             children:[
             Text("Total:\tRs."+cartController.totalPrice.toString(),style: Theme.of(context).textTheme.headline5),
              SizedBox(width: 5,),
              RaisedButton(onPressed: (){},child: Text("Buy Now"),)
            ],),
        )
        ])) 
    )
    );
  
  }
}
class CartDetailsTile extends StatefulWidget {
  final String productId;
  final String productImage;
  final String productName;
  final String sizeChoosen;
  final String productPrice;
  final int quantity;

  const CartDetailsTile({
    Key? key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.sizeChoosen,
    required this.productPrice,
    required this.quantity,
  }) : super(key: key);


  @override
  State<CartDetailsTile> createState() => _CartDetailsTileState();
}

class _CartDetailsTileState extends State<CartDetailsTile> {
  final CartController cartController=Get.find();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5), 
              image:DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop), 
                image: NetworkImage(widget.productImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Wrap(
           crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(child: Icon(Icons.add),onPressed: (){
                  cartController.addToCart(  widget.productId,widget.productImage,widget.productName,widget.sizeChoosen,widget.productPrice,widget.quantity);

                }     
                ,),   
                Text(widget.quantity.toString()),         
                TextButton(child: Icon(Icons.remove),onPressed: (){
                  cartController.removeCart(widget.productId);
                },)
              ],
          ),      
          Text(widget.productName,style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 10,),
          Text("Size:"+widget.sizeChoosen,style: Theme.of(context).textTheme.headline5),
          SizedBox(height: 10,),
          Text(widget.productPrice,style: Theme.of(context).textTheme.headline5),
          SizedBox(height: 10,),
          Divider(color: Colors.grey,thickness: 2,)
        ],
      ),
    );

      
    
  }
}