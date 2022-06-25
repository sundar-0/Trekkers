class User {
  final String? sId;
  final String? email;
  final String? password;
  final String? phone;
  final String? dateJoined;
  User(
      {this.sId,
      this.email,
      this.password,
      this.phone,
      this.dateJoined,
   });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json['_id'],
      email : json['email'],
      password : json['password'],
      phone :json['phone'],
      dateJoined : json['date_joined']
      );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}