import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trekkers_project/screens/dashboard/add/add_screen.dart';

import 'package:video_player/video_player.dart';

import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/controllers/place_controller.dart';
import 'package:trekkers_project/controllers/post_controller.dart';

class HomeScreen extends StatefulWidget {
    static const String routeName = '/home';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(),
        settings: RouteSettings(name: routeName));
  }
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
      final AuthController authController=Get.find();

      final PlaceController placeController=Get.put(PlaceController());
      setState(() {
      token=authController.token.value;
      }); 
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: const Text('Trekkers',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            RecommendedPlaceSection(),
            SizedBox(height: 30,),
            AddScreen(),

            PostSection(token: token,),
           
           
          
          ],),
          
          ),
      ),
    );
  }
}
class StorySection extends StatefulWidget {
  const StorySection({ Key? key }) : super(key: key);

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {

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




class PostSection extends StatefulWidget {
  final String? token;
  const PostSection({
    Key? key,
    required this.token
  }) : super(key: key);

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {

 var posts=[];
  @override
  void initState() {
   fetchAllPosts();
    super.initState();
  }
  // @override
  // void didUpdateWidget(covariant PostSection oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //       fetchAllPosts();
  // }
  Future fetchAllPosts() async{
  print("inside");
  print(widget.token);
  var header={
    "Authorization":"Bearer ${widget.token}"
  };
  final response=await http.get(Uri.parse("$baseUrl/userpost/getAllPost"),headers: header);
  print(response.statusCode);
   if (response.statusCode == 200) {
    final data=jsonDecode(response.body.toString()); 
    print(data);
    print(data);   
    final result=data["result"];
    setState(()  {
      posts= result;
    });
    print(posts[0]['video_url']);
  }
  else{
    posts=[];
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: posts.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PostTile(
                  index: index,
                  videoUrl:posts[index]['video_url']??"",
                  content: posts[index]['post']??"",
                  postImage: posts[index]['image_url']??"",
                  userName: posts[index]['user']['email'].split("@")[0],
                  userImage:posts[index]['user']['user_profile_url']);
            }));
  }
}

// class Posts extends StatelessWidget {
//   final PostController postController = Get.find();
 
//   Posts({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Container(
//         child: ListView.builder(
//             itemCount: postController.posts.length,
//             physics: ClampingScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return PostTile(
//                   index: index,
//                   content: postController.posts[index].content!,
//                   postImage: postController.posts[index].post_image!,
//                   userName: postController.posts[index].user_name!,
//                   userImage: postController.posts[index].user_profile_image!);
//             })));
//   }
// }

class PostTile extends StatelessWidget {
  // final PostController postController = Get.find();
  final int index;
  List postImage;
  List videoUrl;
  final String userName, userImage,content;
  PostTile(
      {Key? key,
      required this.index,
      required this.videoUrl,
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
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             CircleAvatar(
             backgroundImage:NetworkImage(userImage)),
             SizedBox(width: 5,),
              Text(
                userName,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),

          SizedBox(height: 15,),
         Text(
            content,
            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'sans-serif',fontWeight: FontWeight.w400),
          ),
          postImage.isNotEmpty?
          Container(
            height: 200,
            child: GridView.count(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  children: List.generate(postImage.length, (index) {  
                    return Center(  
                      child: Image.network(
                        postImage[index],
                        fit: BoxFit.cover,
                      ),  
                    );  
                  }  
                  )),
          ) :Text(""), 
          videoUrl.isNotEmpty?
           Container(
            height: 200,
            child: GridView.count(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 8.0,  
                  children: List.generate(videoUrl.length, (index) {  
                    return Center(  
                      child:  Chewie(
                      controller: ChewieController(
                      videoPlayerController: VideoPlayerController.network(
                    videoUrl[index]),
                      autoPlay: false,
                      looping: false,
                    ),
                    ),  
                    );  
                  }  
                  )),
          ):Text("") ,
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(
                            Icons.thumb_up_alt_rounded,
                            size: 20,
                            color: Colors.black,
                          )),
            IconButton(onPressed: (){}, icon: Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.black,
                          )),
              //  IconButton(
              //       icon: postController.posts[index].is_favorite.value
              //           ? Icon(
              //               Icons.thumb_up_alt_rounded,
              //               size: 30,
              //               color: Colors.blue,
              //             )
              //           : Icon(
              //               Icons.thumb_up_alt_outlined,
              //               size: 30,
              //               color: Colors.blue,
              //             ),
              //       onPressed: () {
              //         // postController.posts[index].is_favorite.toggle();
              //       },
              //     )),

            ],
          ),  
          SizedBox(height: 5,),
          Divider(thickness: 1,color: Colors.grey,),
        ],
      ),
    );
  }
}

 