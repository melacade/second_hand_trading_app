class UserBean {
  String message;
  int code;
  UserData data;

  UserBean({this.message, this.code, this.data});

  UserBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  String id;
  String phone;
  String avator;
  int authTime;
  String name;
  String token;

  UserData(
      {this.id, this.phone, this.avator, this.authTime, this.name, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    avator = json['avator'];
    authTime = json['authTime'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['avator'] = this.avator;
    data['auth_time'] = this.authTime;
    data['name'] = this.name;
    data['token'] = this.token;
    return data;
  }
}