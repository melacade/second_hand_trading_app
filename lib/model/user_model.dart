import 'package:second_hand_trading_app/api/Api.dart';
import 'package:second_hand_trading_app/base/base_model.dart';
import 'package:second_hand_trading_app/bean/user_bean.dart';

class UserModel extends BaseModel {
  Api _api;

  UserModel(Api api) {
    this._api = api;
  }

  Future<UserBean> login(String name) async {
    load();
    await _api.login(name);
    loaded();
    return null;
  }
}
