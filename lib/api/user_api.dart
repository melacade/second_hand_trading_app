import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class UserApi {
  static var _https = Http.getInstance();

  static Future<void> login(
      String username, String password, String token, Success success, Fail fail) async {
    var data = {"username": username, "password": password, "token" : token};

    await _https.post("/login", data,
        success: (data) => {
              success(data),
            },
        fail: fail);
  }

  static void logout({Success success, Fail fail}) async {
    await _https.get("/logout", null, success: success, fail: fail);
  }

  static Future<void> register(data) {
    return _https.get("/api/user/regiseter", data);
  }

  static Future<void> uploadAvatar(File file,
      {Success success, Fail fail}) async {
    String uploadPath = "/file/upload/img/avatar";

    Map<String, dynamic> map = Map();
    map["file"] = await MultipartFile.fromFile(file.path);

    ///通过FormData
    FormData formData = FormData.fromMap(map);
    await _https.post(uploadPath, formData, success: (data){
      log(data.toString());
      if (success != null) {
        
       success(data);
      }
    });
    return Future.value();
  }
}
