import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/guide_controller.dart';
class GuideScreen extends StatelessWidget {
    static const String routeName = '/guide';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => GuideScreen(),
        settings: RouteSettings(name: routeName));
  }
  const GuideScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GuideController guideController = Get.put(GuideController());
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
       leading: IconButton(
      icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Choose Guide',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: Obx(() {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
  
                  child: ListView.builder(
                      itemCount:guideController.guides.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return GuideCard(index: index);
                      })),
                ),
               
              ],
            ),
          );
        })); 
          

  }
  }



class GuideCard extends StatelessWidget {
  final int index;
  final GuideController guideController = Get.find();

  GuideCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 500,
        decoration: BoxDecoration(color: Colors.teal.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue.shade300,
              // backgroundImage:
              //     NetworkImage(productController.products[index].imageUrl),
            ),
            SizedBox(height:10,),
            Text(guideController.guides[index].guideName!,style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'sans-serif',fontSize:30,
            color: Colors.black87,  
            shadows: ([
              Shadow(
                   color: Colors.grey.shade900.withOpacity(0.5),
           
                  blurRadius: 12
                  ),])),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text('${guideController.guides[index].review!}',style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'sans-serif',fontSize:24,
            color: Colors.black87,  
            shadows: ([
              Shadow(
                  color: Colors.grey.shade900.withOpacity(0.5),
           
                  blurRadius: 12
                  ),]))),
            Icon(Icons.star,color: Colors.amberAccent[200],size: 30,)
            ],),
            SizedBox(height: 10,),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children:guideController.guides[index].knowLanguages!
              .map((e) => Text(e,style: TextStyle(fontSize:14,
            color: Colors.black87,  
          ))).toList()
            ), 
            SizedBox(height: 10,),
            Divider(thickness: 2,),
            Text("Communication Skill"),
            Text(guideController.guides[index].communicationSkill!),
            SizedBox(height: 10,),
            Divider(thickness: 2,),
            Text("Contact"),
            Text(guideController.guides[index].guideContactNo!),
            ElevatedButton(
                      onPressed: () {
                        // Get.to(());
                      },
                      child: Text("Hire")
          )
          ],
        ),
      ),
    );
  }
}