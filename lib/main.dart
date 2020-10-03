import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/pages/components/SearchBox.dart';

void main() {
  runApp(MaterialApp(
      home: new Scaffold(
    appBar: AppBar(
      title: Text("nihao",textAlign: TextAlign.center),
    ),
    body: SearchBox(),
  )));
}
