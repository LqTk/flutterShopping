class MemberLoginInfo {
  LoginInfoData data;
  String message;
  int code;

  MemberLoginInfo({this.data, this.message, this.code});

  MemberLoginInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginInfoData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class LoginInfoData {
  String picUrl;
  String address;
  String name;
  int userId;

  LoginInfoData({this.picUrl, this.address, this.name, this.userId});

  LoginInfoData.fromJson(Map<String, dynamic> json) {
    picUrl = json['picUrl'];
    address = json['address'];
    name = json['name'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this.picUrl;
    data['address'] = this.address;
    data['name'] = this.name;
    data['userId'] = this.userId;
    return data;
  }
}

