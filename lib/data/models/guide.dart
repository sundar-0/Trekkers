class GuidesModel{
  int? guideId;
  String? guideName;
  String? guideProfileImg;
  String? guideContactNo;
  String? review;
  List<String>? knowLanguages;
  String? communicationSkill;
  GuidesModel({this.guideId,this.guideName,this.guideProfileImg,this.guideContactNo,this.review,this.knowLanguages,this.communicationSkill});
}

class GuidesDocument extends GuidesModel{
int? docId;
Map? document={
  'id':{
    'citizenshipId':{},
    'licenseId':{},
    'passport':{}
  },
  'photo':'',
};
bool? isVerified=false;
DateTime? documentCreatedOn;
GuidesDocument({this.docId,this.document,this.isVerified,this.documentCreatedOn});
}

