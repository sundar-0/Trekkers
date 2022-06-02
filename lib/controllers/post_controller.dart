import 'package:get/get.dart';
import 'package:trekkers_project/models/posts.dart';

class PostController extends GetxController {
  var posts = <PostsModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchPosts();
  }

  fetchPosts() async {
    await Future.delayed(Duration(seconds: 1));
    var postsResult = [
      PostsModel(
          post_id: 1,
          user_name: "Hari Yadav",
          user_profile_image:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 1",
          post_image: ""),
      PostsModel(
          post_id: 2,
          user_name: "Bikram Baral",
          user_profile_image:
              "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 2",
          post_image: ""),
      PostsModel(
          post_id: 3,
          user_name: "Jeevan Parajuli",
          user_profile_image:
              "https://images.pexels.com/photos/556666/pexels-photo-556666.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 3",
          post_image: ""),
      PostsModel(
          post_id: 4,
          user_name: "Sanskrit Neupane",
          user_profile_image:
              "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 4",
          post_image: ""),
      PostsModel(
          post_id: 5,
          user_name: "Bibek Kuikel",
          user_profile_image:
              "https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 5",
          post_image: ""),
      PostsModel(
          post_id: 6,
          user_name: "Swasteeka khadka",
          user_profile_image:
              "https://images.pexels.com/photos/598917/pexels-photo-598917.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          content: "This is dummy post 6",
          post_image: ""),
    ];
    posts.value = postsResult;
  }

  void addNewPost(PostsModel post) {
    posts.add(post);

    Get.snackbar("new post added", "you have added new post successfully");
  }

  void deletePost(PostsModel post) {
    print(post.post_id);
    posts.remove(post);
    Get.snackbar("post deleted",
        "The post id ${post.post_id} has been deleted successfully");
  }
}