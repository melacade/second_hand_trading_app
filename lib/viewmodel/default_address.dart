import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/base_view_model.dart';

class DefaultAddress extends BaseViewModel {
  var list = [
  ];
  void defaultChanged() {
    UserApi.getAddressList(
      success: (data) {
        list.clear();
        list.addAll(data);
        list.add({"country": "add"});
      },
    );
    this.loaded();
  }

  void init() {
    UserApi.getAddressList(
      success: (data) {
        list.clear();
        list.addAll(data);
        list.add({"country": "add"});
      },
    );
  }
}
