import 'package:flutter/cupertino.dart';

class UserBean with ChangeNotifier {
  String name;
  int age;

  UserBean({this.name = "", this.age = 0});

  void update(UserBean userBean) {
    this.name = userBean.name;
    this.age = userBean.age;
    notifyListeners();
  }
}
