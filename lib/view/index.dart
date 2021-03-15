import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/components/goods_list.dart';
import 'package:second_hand_trading_app/view/components/search_bar.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: SearchBar(),),
      body: GoodsList(),
    );
  }
}