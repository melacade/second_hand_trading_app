import 'package:second_hand_trading_app/api/Api.dart';
import 'package:second_hand_trading_app/model/user_model.dart';

void main() async {
  var userModel = UserModel(Api());
  var login = await userModel.login("nihao");
  print(login);
}
