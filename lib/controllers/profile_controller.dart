
import 'package:get/get.dart';
import 'package:trekkers_project/data/models/profile.dart';
import 'package:trekkers_project/data/services/profile.dart';
class ProfileController extends GetxController{
var profile=Profile().obs;
ProfileService profileService=ProfileService();


Future profileUser(String id) async{
var result =await profileService.userProfile(id);
profile.value=result;
}

}
