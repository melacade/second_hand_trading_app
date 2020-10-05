import 'package:flutter/material.dart';

import 'file:///E:/second_hand_trading_app/lib/view/DetailPage.dart';

class ListPage extends StatelessWidget {
  ListPage(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('$index'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailPage();
            }));
          },
        ),
      ),
    );
  }
}
