import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/main_page.dart';

class Routes {
  static const String main_page = "/main/mainPage";

  static Route findRoutes(RouteSettings settings) {
    final String name = settings.name;
    return MaterialPageRoute(builder: (_) {
      return _findPage(name, settings.arguments);
    });
  }

  static Widget _findPage(String name, Object arguments) {
    Widget page;
    switch (name) {
      case main_page:
        page = MainPage();
    }
    return page;
  }
}
