import 'package:get/get.dart';
class PostsModel {
  int? post_id;
  String? user_name;
  String? user_profile_image;
  String? content;
  String? post_image;
  PostsModel(
      {this.post_id,
      this.user_name,
      this.user_profile_image,
      this.content,
      this.post_image});
  final is_favorite = false.obs;
}