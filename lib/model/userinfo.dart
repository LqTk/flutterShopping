class UserInfo {
  String name;
  String password;
  int userId;

  UserInfo({this.name, this.password, this.userId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['userId'] = this.userId;
    return data;
  }
}
