import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/common/routes.dart';

import 'components/search_bar.dart';

class ListPage extends StatelessWidget {
  ListPage(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SearchBar(),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            '$index',
            style: TextStyle(fontSize: 20.ssp),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.detailPage, arguments: index);
          },
        ),
      ),
    );
  }
}
