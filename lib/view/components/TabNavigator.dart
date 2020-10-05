import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../ListPage.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settins) {
        WidgetBuilder builder;
        switch (settins.name) {
          case '/':
            builder = (context) => ListPage(index);
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}