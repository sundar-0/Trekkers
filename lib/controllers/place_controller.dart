import 'package:get/get.dart';
import 'package:trekkers_project/data/models/places.dart';



class PlaceController extends GetxController {
  var places = <PlacesModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchRecommendedPlaces();
  }
  fetchRecommendedPlaces() async {
    await Future.delayed(Duration(seconds: 1));
    var recommendedPlacesResult = [
      PlacesModel(place_id: 1,place_name: "Manang",description: "Mananag is very famous for tourism",review:9.5,lat:28.6667,long:84.0167),
      PlacesModel(place_id: 2,place_name: "Mustang",description: "Mustang is very famous for tourism",review:9.5,lat:28.9985,long:83.8473),
      PlacesModel(place_id:3,place_name: "Sauraha",description:"Sauraha is famous place located in chitwan",review:10,lat:27.5848,long:84.5039),
      PlacesModel(place_id: 4,place_name: "Bandipur",description: "Bandipur jau pirati lau",review: 9.5,lat:27.9170 ,long:84.4068),     
    ];
    places.value = recommendedPlacesResult;
  }
}