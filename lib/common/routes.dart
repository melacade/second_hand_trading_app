import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/DetailPage.dart';
import 'package:second_hand_trading_app/view/add_new_security_problem.dart';
import 'package:second_hand_trading_app/view/login_page.dart';
import 'package:second_hand_trading_app/view/main_page.dart';
import 'package:second_hand_trading_app/view/register_page.dart';
import 'package:second_hand_trading_app/view/reset_account.dart';
import 'package:second_hand_trading_app/view/reset_password.dart';
import 'package:second_hand_trading_app/view/search_page.dart';
import 'package:second_hand_trading_app/view/security_center.dart';
import 'package:second_hand_trading_app/view/splash_page.dart';
import 'package:second_hand_trading_app/view/user_info_page.dart';

class Routes {
  static const String splashPage = "/";
  static const String mainPage = "/main/mainPage";
  static const String searchPage = "/searchPage";
  static const String loginPage = "/loginPage";
  static const String detailPage = "/detailPage";
  static const String userInofPage = "/userInfoPage";
  static const String registerPage = "/registerPage";

  static const String resetPassword = "";

  static const String addNewSecurityProblem = "/addNewSecurityProblem";

  static const String resetAccount = "/resetAccount";

  static const String securityCenter = "/securityCenter";

  static Route findRoutes(RouteSettings settings) {
    final String name = settings.name;
    return MaterialPageRoute(builder: (_) {
      return _findPage(name, settings.arguments);
    });
  }

  static Widget _findPage(String name, Object arguments) {
    Widget page;
    switch (name) {
      case splashPage:
        page = SplashPage();
        break;
      case mainPage:
        page = MainPage();
        break;
      case searchPage:
        page = SearchPage();
        break;
      case loginPage:
        page = LoginPage();
        break;
      case detailPage:
        page = DetailPage(arguments);
        break;

      case userInofPage:
        page = UserInfoPage();
        break;
      case registerPage:
        page = RegisterPage();
        break;
      case addNewSecurityProblem:
        page = AddNewSecurityProblem();
        break;
      case resetAccount:
        page = ResetAccount(
          args: arguments,
        );
        break;
      case securityCenter:
        page = SecurityCenter();
        break;
        case resetPassword:
        page = ResetPassword();
        break;
      default:
        page = MainPage();
    }
    return page;
  }
}
