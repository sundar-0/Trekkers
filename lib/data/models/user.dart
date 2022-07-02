class User {
  String? message;
  List<Result>? result;

  User({this.message, this.result});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? userProfileUrl;
  String? sId;
  String? email;
  String? password;
  String? phone;
  String? dateJoined;
  int? iV;

  Result(
      {this.userProfileUrl,
      this.sId,
      this.email,
      this.password,
      this.phone,
      this.dateJoined,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    userProfileUrl = json['user_profile_url'];
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    dateJoined = json['date_joined'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_profile_url'] = this.userProfileUrl;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['date_joined'] = this.dateJoined;
    data['__v'] = this.iV;
    return data;
  }
}