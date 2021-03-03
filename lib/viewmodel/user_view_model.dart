import 'dart:developer';
import 'dart:io';

import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/base_view_model.dart';
import 'package:second_hand_trading_app/model/user.dart';
import 'package:second_hand_trading_app/utils/database/database_utils.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class UserViewModel extends BaseViewModel {
  static UserBean userBean = UserBean();
  static UserViewModel curr = UserViewModel();
  DatabaseUtils databaseUtils = DatabaseUtils();
  UserViewModel(){
    curr = this;
  }

  void loadData() async {
    this.load();
    userBean.data = await databaseUtils.findCurUSer();
    this.loaded();
  }

  Future<void> login(String username, String password, String token,
      {Success success, Fail fail}) async {
    this.load();
    await UserApi.login(username, password, token, (json) async {
      userBean = UserBean.fromJson(json);
      if (userBean.code == 200) {
        await databaseUtils.addNewLogin(userBean.data);
        if (success != null) {
          success(json);
        }
        this.loaded();
      } else {
        fail(userBean.message, userBean.code);
      }
    }, (reason, code) {
      log(reason);
      if (fail != null) {
        fail(reason, code);
      }
    });
  }

  void logOut({Success success, Fail fail}) async {
    UserApi.logout(success: (data) async {
      await databaseUtils.deleteUser();
      userBean.data = UserData();
      userBean.data.name = "Not logged in";
      userBean.data.avator = "default";
      this.loaded();
      success(data);
    }, fail: (reason, code) {
      fail(reason, code);
    });
  }

  void uploadAvatar(File file, {Success success, Fail fail}) async {
    await UserApi.uploadAvatar(file, success: (data) async{
      var user = UserBean.fromJson(data);
      if (user.code == 200) {
        userBean = user;
        await databaseUtils.updateCurUser(user.data);
        this.loaded();
        if (success != null) {
          success(data);
        }
      }
    }, fail: (reason, code) {
      log(reason);
      fail(reason, code);
    });
  }

  void register(String account,String phone, String name, String password, String salt,{Success success, Fail fail}) async{
    await UserApi.register(account,phone,name,password,salt, success: (data) async{
      var user = UserBean.fromJson(data);
      log(user.data.toString());
      if (user.code == 200) {
        userBean = user;
        await databaseUtils.addNewLogin(user.data);
        
        if (success != null) {
          success(data);
        }
      }
    }, fail: (reason, code) {
      log(reason);
      fail(reason, code);
    });
  }

  
}
