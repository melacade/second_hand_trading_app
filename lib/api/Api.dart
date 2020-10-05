import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:second_hand_trading_app/bean/user_bean.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';

class Api {
  String url = "www.baidu.com";
  Future<UserBean> login(String name) {
    Http.getInstance().get(url, {}, success: (dynamic json) {
      debugPrint(jsonEncode(json).toString());
    });
    return null;
  }
}
