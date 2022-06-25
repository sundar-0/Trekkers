class Profile {
  String? message;
  Result? result;

  Profile({this.message, this.result});

  Profile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? email;
  String? password;
  String? phone;
  String? dateJoined;
  int? iV;

  Result(
      {this.sId,
      this.email,
      this.password,
      this.phone,
      this.dateJoined,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    dateJoined = json['date_joined'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['date_joined'] = this.dateJoined;
    data['__v'] = this.iV;
    return data;
  }
}
