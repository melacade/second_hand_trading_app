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
    map["files"] = await MultipartFile.fromFile(file.path);

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

  static Future<void> addNewSecurityProblem(
      String problem1,
      String problem2,
      String problem3,
      String answer1,
      String answer2,
      String answer3,
      String password,
      {Success success,
      Fail fail}) async {
    List<Map<String, dynamic>> list = List();
    list.add({"question": problem1, "answer": answer1});
    list.add({
      "question": problem2,
      "answer": answer2,
    });
    list.add({"question": problem3, "answer": answer3});
    Map<String, dynamic> map = {'questions': list, "password": password};
    await _https.post("/api/user/createSecurityQuestion", map, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.message);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
    return Future.value();
  }

  static void checkSecurityProblem(
      {Success success, Fail fail, String account}) async {
    await _https.get("/api/user/checkSecuriy", {'account': account},
        success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(data);
        }
        log("检查到有密保问题");
      } else {
        if (fail != null) {
          fail(res.message, res.code);
        }
        log("检查到没有密保问题");
      }
    }, fail: (message, code) {});
  }

  static void checkPaymentPDW({Success success}) async {
    await _https.get("/api/user/checkPaymentSecurity", null, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(data);
        }
        log("支付密码检测成功");
      }
    }, fail: (message, code) {});
  }

  static void validateProblems(dynamic problems,
      {Success success, String account}) {
    _https.post("/api/user/validateProblems",
        {"questions": problems, "account": account}, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.data);
        log(res.message);
      }
    }, fail: (data, code) {});
  }

  static void resetSecurityProblem(String problem1, String problem2,
      String problem3, String answer1, String answer2, String answer3,
      {Success success, Fail fail}) {
    List<Map<String, dynamic>> list = List();
    list.add({"question": problem1, "answer": answer1});
    list.add({
      "question": problem2,
      "answer": answer2,
    });
    list.add({"question": problem3, "answer": answer3});
    _https.post("/api/user/resetSecurityProblems", list, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.message);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
  }

  static void addPayment(String password, String payment,
      {Success success, Fail fail}) {
    Map<String, dynamic> map = {"password": password, "payment": payment};
    _https.post("/api/user/addPayment", map, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.message);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
  }

  static void resetPayment(String password, String oldPayment, String payment,
      {Success success, Fail fail}) {
    Map<String, dynamic> map = {
      "password": password,
      "oldPayment": oldPayment,
      "payment": payment
    };
    _https.post("/api/user/resetPayment", map, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.message);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
  }

  static void resetPassword(String password,
      {Success success, Fail fail, String account}) {
    Map<String, dynamic> map = {'password': password, 'account': account};

    _https.post("/api/user/resetPassword", map, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) success(res.message);
        log(res.message);
      } else {
        log(res.message);
        if (fail != null) fail(res.message, res.code);
      }
    }, fail: (data, code) {});
  }

  static void getAddressList({Success success}) {
    _https.get("/api/user/getAddress", null, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void addAddress(Map addr, {Success success}) {
    _https.post("/api/user/addUserAddress", addr, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void updateAddress(Map data, {Success success}) {
    _https.post("/api/user/updateAddress", data, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.message);
        }
      }
    });
  }

  static void getDefaultAddress({Success success}) {
    _https.get("/api/user/getDefaultAddress", null, success: (data) {
      var res = NomalResponse.fromJson(data);
      log(res.message);
      if(res.code == 200){
        if(success!=null){
          success(res.data);
        }
      }
    });
  }
}
