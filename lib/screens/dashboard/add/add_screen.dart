import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/screens/dashboard/home/home_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class AddScreen extends StatefulWidget {
    static const String routeName = '/guide';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => AddScreen(),
        settings: RouteSettings(name: routeName));
  }
  const AddScreen({ Key? key }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
  
}

class _AddScreenState extends State<AddScreen> {
  
  // File? image;
  List<File> fileMediaArray = [];
  VideoPlayerController? _videoPlayerController;
  String? post;
  String? loginToken;
  bool isAdded=false;
  
  Future pickVideo() async{
    final video=await ImagePicker().pickVideo(source: ImageSource.gallery);
    if(video==null) return;
    final videoTemp=File(video.path);
    setState(() {
      fileMediaArray.add(videoTemp);
    });

    _videoPlayerController =VideoPlayerController.file(videoTemp)..initialize().then((_) {
      setState(() { });
      _videoPlayerController!.play();
    });
    
  
  
  }

  
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        fileMediaArray.add(imageTemp);
      });

      // setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        fileMediaArray.add(imageTemp);
      });

      // setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  

  Future addPost() async{
    print("Add new post");
    // http://localhost:5000/api/userpost/62a897b79985bb17f8cd6be6/createpost

    var postUri = Uri.parse("http://10.0.2.2:5000/api/userpost/62a897b79985bb17f8cd6be6/createpost");
    var request = http.MultipartRequest("POST", postUri);

    //yedi post ra media duitai xa rey
    if(fileMediaArray.isNotEmpty && post!=null){
      print(fileMediaArray);
      print(post);
      request.fields['userPost']=post!;
      for (var item in fileMediaArray) {
      String mediaType=lookupMimeType(item.path)!.split("/")[0];
      print(mediaType);
      if(mediaType=="image")
       {
        
       request.files.add(
        http.MultipartFile('medias',item.readAsBytes().asStream(),item.lengthSync(),filename: item.path,contentType: MediaType('image','jpeg'))
      ); 
       } 
      else
      {
      request.files.add(
        http.MultipartFile('medias',item.readAsBytes().asStream(),item.lengthSync(),filename: item.path,contentType: MediaType('video','mp4'))
      ); 
      }

      }
    }
    //yedi post xaina rey only media matra xa rey
    else if(fileMediaArray.isNotEmpty && post==null){
      print(fileMediaArray);
      print(post);
      for (var item in fileMediaArray) {
       String mediaType=lookupMimeType(item.path)!.split("/")[0];
       if(mediaType=="image")
       {
       request.files.add(
        http.MultipartFile('medias',item.readAsBytes().asStream(),item.lengthSync(),filename: item.path,contentType: MediaType('image','jpg'))
      ); 
       } 
      else
      {
      request.files.add(
        http.MultipartFile('medias',item.readAsBytes().asStream(),item.lengthSync(),filename: item.path,contentType: MediaType('video','mp4'))
      ); 
      }
      }
      }
      else{
        request.fields['userPost']=post!;
      }
    request.headers["Authorization"]="Bearer $loginToken";
    request.send().then((response) async {
      if (response.statusCode == 200){
        Navigator.of(context).pushNamed('/home');
      
          //to do fetch user profile image
      }
    });
    
    }
    
    //yedia post matra xa ra media xaina rey
  //   else if(fileMediaArray.isEmpty && post!=null){
  //     request.fields['userPost']=post!;
  //   }
  //   request.headers["Authorization"]="Bearer $loginToken";
  //   request.send().then((response) async {
  //     if (response.statusCode == 200){
  //        print("Added");
  //         //to do fetch user profile image
  //     }
  //   });
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(fileMediaArray);
    final AuthController authController=Get.find();
    final token=authController.login.value.token;
    setState(() {
    loginToken=token;
    });
  
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: const Text('Add',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: Column(
        children: [
        TextFormField(
               decoration: inputDecoration.copyWith(
               hintText: "Write Something"),
               maxLines: 5,      
              onChanged: (value) {
                    setState(() {
                        post = value;
                        });
                    },           
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         IconButton(onPressed: () async{
          await pickImageC();
         }, icon: Icon(Icons.camera_alt),iconSize: 26,),
         IconButton(onPressed: () async{
          await pickImage();
         }, icon: Icon(Icons.image_outlined,),iconSize: 26,),
         IconButton(onPressed: () async{
          await pickVideo();
         }, icon: Icon(Icons.video_call_sharp),iconSize: 26,)  
          ],
        ),
        TextButton(onPressed: () async{
          await addPost();
        }, child:Text("Post") ),
          SizedBox(height: 20,),
          fileMediaArray.length!=0?Container(
            height: 200,
            decoration: BoxDecoration(
            color:Colors.grey ,
             borderRadius: BorderRadius.circular(5),
            ),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(  
                maxCrossAxisExtent: 210,
                childAspectRatio: 3/ 2,
                crossAxisSpacing: 4,
                mainAxisExtent: 180,
                ),
            itemCount: fileMediaArray.length,
            itemBuilder: (BuildContext ctx, index) {
              String mediaType=lookupMimeType(fileMediaArray[index].path)!.split("/")[0];
              return mediaType=="image"?
              SizedBox(
                child: Image.file(fileMediaArray[index]),
                )
             :
             SizedBox(  
               child: Chewie(controller: ChewieController(
                videoPlayerController:_videoPlayerController!,
                )),
             );
            //  _videoPlayerController!.value.isInitialized?AspectRatio(
            //         aspectRatio: _videoPlayerController!.value.aspectRatio,
            //         child: VideoPlayer(_videoPlayerController!),
            //     ):Container();
            // SizedBox(
            //   width: 20,
            //   height: 20,
            //   child: Chewie(
            //   controller: ChewieController(
            //   videoPlayerController: VideoPlayerController.asset(
            //   fileMediaArray[index].path,
            //             ),
            //             ),  
            //             ),
            // );
            }),
          ):Text("No image selected"),
          // image != null ? SizedBox(child: Image.file(image!),height: MediaQuery.of(context).size.height/4,): Text("No image selected")
        ],
      )
    );
  }
}