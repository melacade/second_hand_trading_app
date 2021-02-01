import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/DetailPage.dart';
import 'package:second_hand_trading_app/view/login_page.dart';
import 'package:second_hand_trading_app/view/main_page.dart';
import 'package:second_hand_trading_app/view/search_page.dart';
import 'package:second_hand_trading_app/view/splash_page.dart';

class Routes {
  static const String splashPage = "/";
  static const String mainPage = "/main/mainPage";
  static const String searchPage = "/searchPage";
  static const String loginPage = "/loginPage";
  static const String detailPage = "/detailPage";

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
      default:
        page = MainPage();
    }
    return page;
  }
}
