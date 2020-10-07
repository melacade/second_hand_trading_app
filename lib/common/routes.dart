import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/main_page.dart';
import 'package:second_hand_trading_app/view/splash_page.dart';

class Routes {
  static const String splashPage = "/";
  static const String mainPage = "/mainPage";

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
      default:
        page = MainPage();
    }
    return page;
  }
}
