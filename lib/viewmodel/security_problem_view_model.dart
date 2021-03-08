import 'dart:developer';

import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/base_view_model.dart';
import 'package:second_hand_trading_app/model/noaml_response.dart';
import 'package:second_hand_trading_app/model/security_problems.dart';

class SecurityProblemViewModel extends BaseViewModel{
  SecurityProblems securityProblems =  SecurityProblems(code: 400,data: null,message: "没有密保问题");
  bool has = false;
  void cheack({String account}){
    UserApi.checkSecurityProblem(success: (json) {
      securityProblems = SecurityProblems.fromJson(json);
      this.loaded();
    } ,fail: (reason, code) {
      securityProblems = SecurityProblems(code: code,data: null,message: reason);
      this.loaded();
    },account: account);
  }

  void checkPayment(){
    UserApi.checkPaymentPDW(success: (json) {
      has = NomalResponse.fromJson(json).data;
      this.loaded();
    });
  }

  void general(){
    cheack();
    checkPayment();
  }
}