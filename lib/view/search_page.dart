import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/components/search_body.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SearchBody(),
    );
  }
}
