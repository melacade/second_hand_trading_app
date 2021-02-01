import 'package:second_hand_trading_app/utils/http/http_utils.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class UserApi{
  static var _https = Http.getInstance();

  static void login(String username, String password, Success success, Fail fail)  {
    var data = {
      "username" : username,
      "password" : password
    };
    
    _https.post("/login", data,success:(data)=>{
      success(data),
    },fail: fail);
  }  

  static void logout() async{
    await _https.get("/logout",null);
  }

  static Future<void> register(data){
    return _https.get("/api/user/regiseter",data );
  }
}