
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:http_parser/http_parser.dart';

class ProfilePic extends StatefulWidget {
  final String userId;
  const ProfilePic({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  File? image;
  String? loginToken;
  String? imgUrl;

  @override
initState()  {
    super.initState();
     fetchProfileImage();
  }
  
  Future pickImage() async {
    print("Pressed");
    try {

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);
      print(imageTemp);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);
      print(imageTemp);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  
  Future uploadFile() async {
    print("Inside upload file");

    print(widget.userId);
    print(loginToken);

    var postUri = Uri.parse("$baseUrl/user/${widget.userId}/uploadimage");
    var request = http.MultipartRequest("POST", postUri);
    if(image!=null){
    request.files.add(
        http.MultipartFile(
           'file',
            image!.readAsBytes().asStream(),
            image!.lengthSync(),
            filename: image!.path,
          contentType: MediaType('image','jpeg'),
        ),
    );
    }
 
    // request.files.add(http.MultipartFile.fromBytes('file', await File.fromUri(image!.uri).readAsBytes(), contentType:  MediaType('image', 'jpeg')));
    request.headers["Authorization"]="Bearer $loginToken";
    request.send().then((response) async {
      if (response.statusCode == 200){
         await fetchProfileImage();
          //to do fetch user profile image
      }
    });
  }

Future fetchProfileImage() async{
    final response=await http.get(Uri.parse("$baseUrl/user/${widget.userId}/fetchimage"));
    if (response.statusCode == 200) {
    final data=jsonDecode(response.body.toString());    
    print(data); 
    setState(()  {
      imgUrl=  data["result"][0]["user_profile_url"];
    });
    print(imgUrl);
  
    } else {
     imgUrl=null;
    }
  }


 
 @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find();
    final token=authController.login.value.token;
    setState(() {
    loginToken=token;
    });
     return SizedBox(
      height: 130,

      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          if (imgUrl!=null) CircleAvatar(
             backgroundImage:NetworkImage(imgUrl!),
             onBackgroundImageError:(exception, stackTrace) {
              if(!exception.isBlank!){

              }
             },
          ),
          
        Positioned(
          bottom: 5,
          left: 30,
          child:TextButton(child:Icon(Icons.add,color: Colors.white,size: 35, ),onPressed: () async {
            await pickImage();
            await uploadFile();
        
          }, )),
            
        
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                      await pickImageC();
                      await uploadFile();
                     
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}




