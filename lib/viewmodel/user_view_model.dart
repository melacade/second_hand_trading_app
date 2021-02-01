import 'dart:developer';

import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/base_view_model.dart';
import 'package:second_hand_trading_app/model/user.dart';
import 'package:second_hand_trading_app/utils/database/database_utils.dart';

class UserViewModel extends BaseViewModel{
  UserBean userBean = UserBean();
  DatabaseUtils databaseUtils = DatabaseUtils();
  void loadData() async{
    this.load();
    userBean.data = await databaseUtils.findCurUSer();
    this.loaded();
  }

  void login(String username, String password,){
    this.load();
    UserApi.login(username, password, (json) async{ 
      userBean = UserBean.fromJson(json);
      await databaseUtils.addNewLogin(userBean.data);
    }, (reason, code) { 
      log(reason);
    });
    this.loaded();
  }

}