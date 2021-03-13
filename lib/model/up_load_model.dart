class UpLoadModel {
  String message;
  int code;
  List<String> data;

  UpLoadModel({this.message, this.code, this.data});

  UpLoadModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}