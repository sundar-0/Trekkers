import 'package:get/get.dart';
import 'package:trekkers_project/data/models/guide.dart';




class GuideController extends GetxController {
  var guides = <GuidesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGuidesList();
  }
  fetchGuidesList() async {
    await Future.delayed(Duration(seconds: 1));
    var guidesResult = [
      GuidesModel(guideId:1,guideName: "Sundar Dumre",guideProfileImg: "",guideContactNo:"+9779810201232",review: "4.5",knowLanguages: ["Hindi","Nepali","English","Spanish","Chinese"],communicationSkill: "fluently"),
      GuidesModel(guideId:2,guideName: "Suraj Pandey",guideProfileImg: "",guideContactNo:"+9779842910122",review: "4.5",knowLanguages: ["Hindi","Nepali","English","Korean"],communicationSkill: "moderate"),
      GuidesModel(guideId:1,guideName: "Yajju Chansi",guideProfileImg: "",guideContactNo:"+9779829129812",review: "4.5",knowLanguages: ["Hindi","Nepali","Portugese"],communicationSkill: "fluently"),
      GuidesModel(guideId:1,guideName: "Bibek Poudel",guideProfileImg: "",guideContactNo:"+9779812046629",review: "4.5",knowLanguages: ["Hindi","Nepali","English","Japanese","Chinese"],communicationSkill: "intermediate"),
    ];
    guides.value = guidesResult;
  }
}