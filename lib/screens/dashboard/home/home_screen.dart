import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/place_controller.dart';
import 'package:trekkers_project/controllers/post_controller.dart';
class HomeScreen extends StatelessWidget {
    static const String routeName = '/home';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(),
        settings: RouteSettings(name: routeName));
  }
  const HomeScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      final PostController postController = Get.put(PostController());
      final PlaceController placeController=Get.put(PlaceController());
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: const Text('Trekkers',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            StorySection(),
            RecommendedPlaceSection(),
            PostSection()
          
          ],),
          
          ),
      ),
    );
  }
}
class StorySection extends StatelessWidget {
  const StorySection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Story Section"));
  }
}

class RecommendedPlaceSection extends StatelessWidget {
  final PlaceController placeController=Get.find();
   RecommendedPlaceSection({ Key? key }) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          height: 200,
          child: ListView.builder(
              itemCount: placeController.places.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return PlaceTile(
                  index: index,
                  review: placeController.places[index].review!,
                  lat:placeController.places[index].lat!,
                  long: placeController.places[index].long!,
                  placeName: placeController.places[index].place_name!,
                  placeDesc: placeController.places[index].description!,
                  );
              }),
        );
      }
    );
  }
}


class PlaceTile extends StatelessWidget {
  final int index;
  final double review,lat,long;
  final String placeName, placeDesc;
   PlaceTile(
      {Key? key,
      required this.index,
      required this.review,
      required this.lat,
      required this.long,
      required this.placeName,
      required this.placeDesc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(5),
      child: Stack(
        children: <Widget>[
          Container(
          width: 180,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
            
            image:DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop), 
              image: NetworkImage("https://images.pexels.com/photos/2419022/pexels-photo-2419022.jpeg?cs=srgb&dl=pexels-david-geib-2419022.jpg&fm=jpg"),
              fit: BoxFit.cover,
    
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Text(
        //     placeName,
        //     style: 
        //     TextStyle(
        //       fontSize: 30,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //       shadows: ([
        //       Shadow(
        //           color: Colors.black.withOpacity(0.3),
        //           offset: const Offset(15, 15),
        //           blurRadius: 15
        //           ),]),
        //     ),
         
        
            
        //     ),
        // ),
             Positioned(
               top: 50,
               left: 15,
               child: Text(
                 placeName,
                 style: 
                 TextStyle(
                   fontSize: 32,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                   shadows: ([
                   Shadow(
                       color: Colors.black.withOpacity(0.3),
                       offset: const Offset(15, 15),
                       blurRadius: 20
                       ),]),
                 ),
                 ),
             ),

            Positioned(
               bottom: 10,
               left: 5,
               child: Text(
                 placeDesc,
                 style: 
                 TextStyle(
                   fontSize: 16,
                
                   color: Colors.white,
                        shadows: ([
                   Shadow(
                       color: Colors.black.withOpacity(0.5),
                       offset: const Offset(15, 15),
                       blurRadius: 40
                       ),]),
                   
                 ),
                 
             ))
        ]
      ),
      );
  }
}




class PostSection extends StatelessWidget {
  final PostController postController = Get.find();

  PostSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        child: ListView.builder(
            itemCount: postController.posts.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PostTile(
                  index: index,
                  content: postController.posts[index].content!,
                  postImage: postController.posts[index].post_image!,
                  userName: postController.posts[index].user_name!,
                  userImage: postController.posts[index].user_profile_image!);
            })));
  }
}

class Posts extends StatelessWidget {
  final PostController postController = Get.find();
 
  Posts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        child: ListView.builder(
            itemCount: postController.posts.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PostTile(
                  index: index,
                  content: postController.posts[index].content!,
                  postImage: postController.posts[index].post_image!,
                  userName: postController.posts[index].user_name!,
                  userImage: postController.posts[index].user_profile_image!);
            })));
  }
}

class PostTile extends StatelessWidget {
  final PostController postController = Get.find();

  final int index;
  final String userName, userImage, postImage, content;
  PostTile(
      {Key? key,
      required this.index,
      required this.userName,
      required this.userImage,
      required this.postImage,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              userImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            userName,
            style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            content,
            style: TextStyle(color: Colors.black54),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => IconButton(
                    icon: postController.posts[index].is_favorite.value
                        ? Icon(
                            Icons.thumb_up_alt_rounded,
                            size: 30,
                            color: Colors.blue,
                          )
                        : Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 30,
                            color: Colors.blue,
                          ),
                    onPressed: () {
                      postController.posts[index].is_favorite.toggle();
                    },
                  )),
              IconButton(
                  onPressed: () {
                    postController.deletePost(postController.posts[index]);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.blue,
                  )
                  )
            ],
          ),
        ],
      ),
    );
  }
}