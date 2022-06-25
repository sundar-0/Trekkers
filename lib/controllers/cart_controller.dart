import 'package:get/get.dart';
class CartController extends GetxController{
  var cartItem=[].obs;
  int get totalPrice{
  int totalPrice=0;
  for (var element in cartItem) { 
    int price=int.parse(element['price'].split('.')[1]);
    int quantity=element['quantity'];
    totalPrice+=price*quantity;
  }
  return totalPrice;
  }
void addToCart( String productId,String productImage,String productName,String sizeChoosen,String price,int quantity){
        var cart={
            'product_id':productId,
            'product_image':productImage,
            'product_name':productName,
            'size_choosen':sizeChoosen,
            'price':price,
            'quantity':quantity
          };
          if(cartItem.any((item) => item['product_id']==productId)){
            int index = cartItem.indexWhere((element) => element["product_id"] == productId);
            print(index);

            cartItem[index]['quantity']+=1;
          }
          else{
            cartItem.add(cart);
          }
          cartItem.refresh();
          
          Get.snackbar(
            "Product Added",
            "You have Added ${productName} Successfully",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
 
}
void removeCart(String productId){
  int index = cartItem.indexWhere((element) => element["product_id"] == productId);
  if(cartItem[index]['quantity']<=1){
  cartItem.remove(cartItem[index]);
  }
  else{
    cartItem[index]['quantity']-=1;
  }
  cartItem.refresh();
  Get.snackbar(
            "Product Deleted",
            "You have Deleted product Successfully",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
  );
}

}