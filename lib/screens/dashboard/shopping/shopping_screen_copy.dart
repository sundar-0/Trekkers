
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trekkers_project/controllers/category_controller.dart';


class ShoppingScreen extends StatefulWidget {
    static const String routeName = '/shopping';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => ShoppingScreen(),
        settings: RouteSettings(name: routeName));
  }
  const ShoppingScreen({ Key? key }) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  Icon customIcon = Icon(Icons.search,color: Colors.black,);
 Widget customSearchBar = Text('Shopping',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800));
  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController=Get.put(CategoryController());
    return Scaffold(
    appBar: AppBar(
      elevation: 0,
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
       onPressed: () {
    setState(() {
    if (customIcon.icon == Icons.search) {
     if (customIcon.icon == Icons.search) {
   customIcon = const Icon(Icons.cancel,color: Colors.teal,);
   customSearchBar = const ListTile(
   leading: Icon(
    Icons.search,
    color: Colors.teal,
    size: 28,
   ),
   title: TextField(
    
    decoration: InputDecoration(
    
    hintText: 'Type Something...',
    hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 18,
     fontStyle: FontStyle.italic,
    ),
    border: InputBorder.none,
    ),
    style: TextStyle(
    color: Colors.black,
    ),
   ),
   );
  } 
    } else {
     customIcon = const Icon(Icons.search,color: Colors.black);
     customSearchBar = Text('Shopping',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800));
    }
    });
   },
        icon: customIcon,
        ),
        
        ],
 

      ),
    
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Text("Category ",style: 
                 TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                   color: Colors.teal,
                   shadows: ([
                   Shadow(
                       color: Colors.white.withOpacity(0.5),
                       offset: const Offset(12, 12),
                       blurRadius: 20
                       ),]),
                 ),),
      MenuBarSection(),
      Divider(thickness: 2,color: Colors.teal),
      SizedBox(height: 10,),
       Text("All Products",style: 
                 TextStyle(
                   fontSize: 18,
            
                   fontWeight: FontWeight.bold,
                   color: Colors.teal,
                   shadows: ([
                   Shadow(
                       color: Colors.white.withOpacity(0.5),
                       offset: const Offset(12, 12),
                       blurRadius: 20
                       ),]),
                 ),),
      Divider(thickness: 2,color: Colors.teal),
      Flexible(child:GridView.count(
    primary: false,
    shrinkWrap: true,
    padding: EdgeInsets.all(10),
    crossAxisSpacing: 20,
    mainAxisSpacing: 50,
    crossAxisCount: 2,
    children: <Widget>[
          Container(
                width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image:DecorationImage(
                  image: NetworkImage("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY"),
                  fit: BoxFit.cover,
                ),     
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Some Random Products",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                SizedBox(height: 40,),
                Text("Rs:1200",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_cart), label: Text("Cart")),
                RaisedButton(onPressed: (){},child: Text("Visit"),)]
                )
              
              ],),
            ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image:DecorationImage(
                  image: NetworkImage("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY"),
                  fit: BoxFit.cover,
                ),     
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Some Random Products",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                SizedBox(height: 40,),
                Text("Rs:1200",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_cart), label: Text("Cart")),
                RaisedButton(onPressed: (){},child: Text("Visit"),)]
                )
              
              ],),
            ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image:DecorationImage(
                  image: NetworkImage("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY"),
                  fit: BoxFit.cover,
                ),     
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Some Random Products",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                SizedBox(height: 40,),
                Text("Rs:1200",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_cart), label: Text("Cart")),
                RaisedButton(onPressed: (){},child: Text("Visit"),)]
                )
              
              ],),
            ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image:DecorationImage(
                  image: NetworkImage("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY"),
                  fit: BoxFit.cover,
                ),     
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Some Random Products",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                SizedBox(height: 40,),
                Text("Rs:1200",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_cart), label: Text("Cart")),
                RaisedButton(onPressed: (){},child: Text("Visit"),)]
                )
              
              ],),
            ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image:DecorationImage(
                  image: NetworkImage("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY"),
                  fit: BoxFit.cover,
                ),     
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Some Random Products",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                SizedBox(height: 40,),
                Text("Rs:1200",style:TextStyle(color: Colors.teal,backgroundColor: Colors.white)),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.shopping_cart), label: Text("Cart")),
                RaisedButton(onPressed: (){},child: Text("Visit"),)]
                )
              
              ],),
            ),
      ]
    ))
    ]
    ));
  }
}
class MenuBarSection extends StatelessWidget {
  final CategoryController categoryController=Get.find();
   MenuBarSection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          height: 100,
          child: ListView.builder(
              itemCount: categoryController.categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryMenuTile(
                  index: index,
                  catName: categoryController.categories[index].cat_name!,
                  catImg:categoryController.categories[index].cat_img!          
                  );
              }),
        );
      }
    );
  }
}

class CategoryMenuTile extends StatelessWidget {
  final int index;
  final String catName,catImg;
  CategoryMenuTile({ Key? key,required this.index,required this.catName,required this.catImg}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(5),
      child: Stack(
      
        children: <Widget>[
      
          Container(
          width: 120,   
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image:DecorationImage(
              image: NetworkImage(catImg),
              fit: BoxFit.cover,
    
            ),
          ),
        ),
        Positioned(
               bottom: 0, 
              
               child: Text(
                 catName,
                 style: 
                 TextStyle(
                   fontSize: 14,
                   backgroundColor: Color(0xffffbb33),
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                   shadows: ([
                   Shadow(
                       color: Colors.black.withOpacity(0.5),
                       offset: const Offset(12, 12),
                       blurRadius: 20
                       ),]),
                 ),
                 ),
             ),

           
        ]
      ),
      );
  }
}


// Card(
//       color: Colors.teal,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//            ListTile(
//             leading: SizedBox(  
//             height: 100.0,
//             width: 100.0, 
//             child: Image.network("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY")
//             ),
//             title: Text('The Enchanted Nightingale'),
//             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton(
//                 child: const Text('BUY'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//               TextButton(
//                 child: const Text('LISTEN'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Card(
//       color: Colors.teal,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//            ListTile(
//             leading: SizedBox(  
//             height: 100.0,
//             width: 100.0, 
//             child: Image.network("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY")
//             ),
//             title: Text('The Enchanted Nightingale'),
//             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton(
//                 child: const Text('BUY'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//               TextButton(
//                 child: const Text('LISTEN'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ],
//       ),
//     ),Card(
//       color: Colors.teal,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//            ListTile(
//             leading: SizedBox(  
//             height: 100.0,
//             width: 100.0, 
//             child: Image.network("https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY")
//             ),
//             title: Text('The Enchanted Nightingale'),
//             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton(
//                 child: const Text('BUY'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//               TextButton(
//                 child: const Text('LISTEN'),
//                 onPressed: () {/* ... */},
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ],
//       ),
//     )



//  Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[100],
//         child: const Text("1"),
//       ),
//         Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[200],
//         child: const Text("2"),
//       ),
//        Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[200],
//         child: const Text("3"),
//       ),
//        Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[400],
//         child: const Text("4"),
//       ),
//       Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[400],
//         child: const Text("5"),
//       ),
//       Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[400],
//         child: const Text("6"),
//       ),
//          Container(
//         padding: const EdgeInsets.all(8),
//         color: Colors.teal[400],
//         child: const Text("7"),
//       ),
      


//  GridView.builder(
//   itemCount: 100,
//   itemBuilder: (context, index) => ProductListTile(index),
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       childAspectRatio: 2,
//   ),
// ),
//     );
// class ProductListTile extends StatelessWidget {
//   final int itemNo;

//   const ProductListTile(
//     this.itemNo,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final Color color = Colors.primaries[itemNo % Colors.primaries.length];
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         tileColor: color.withOpacity(0.3),
//         onTap: () {},
//         leading: Container(
//           width: 50,
//           height: 30,
//           color: color.withOpacity(0.5),
//           child: Placeholder(
//             color: color,
//           ),
//         ),
//         title: Text(
//           'Product $itemNo',
//           key: Key('text_$itemNo'),
//         ),
//       ),
//     );
//   }
// }