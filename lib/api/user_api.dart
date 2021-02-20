import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:second_hand_trading_app/model/noaml_response.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class UserApi {
  static var _https = Http.getInstance();

  static Future<void> login(String username, String password, String token,
      Success success, Fail fail) async {
    var data = {"username": username, "password": password, "token": token};

    await _https.post("/login", data,
        success: (data) => {
              success(data),
            },
        fail: fail);
  }

  static void logout({Success success, Fail fail}) async {
    await _https.get("/logout", null, success: success, fail: fail);
  }

  static Future<void> register(
      String account, String phone, String name, String password, String salt,
      {Success success, Fail fail}) async {
    Map<String, dynamic> map = Map();
    map['account'] = account;
    map['phone'] = phone;
    map['password'] = password;
    map['name'] = name;
    map['salt'] = salt;
    await _https.post("/api/user/register", map, success: success, fail: fail);
    return Future.value();
  }

  static Future<void> uploadAvatar(File file,
      {Success success, Fail fail}) async {
    String uploadPath = "/file/upload/img/avatar";

    Map<String, dynamic> map = Map();
    map["file"] = await MultipartFile.fromFile(file.path);

    ///通过FormData
    FormData formData = FormData.fromMap(map);
    await _https.post(uploadPath, formData, success: (data) {
      log(data.toString());
      if (success != null) {
        success(data);
      }
    });
    return Future.value();
  }

  static Future<void> addNewSecurityProblem(String problem1, String problem2,
      String problem3, String answer1, String answer2, String answer3,
      {Success success, Fail fail}) async {
    List<Map<String, dynamic>> list = List();
    list.add({"question": problem1, "answer": answer1});
    list.add({
      "question": problem2,
      "answer": answer2,
    });
    list.add({"question": problem3, "answer": answer3});
    await _https.post("/api/user/createSecurityQuestion", list,
        success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.data);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
    return Future.value();
  }
}
