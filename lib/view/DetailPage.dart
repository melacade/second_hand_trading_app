import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.index);
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('DetailPage ${index}'),
      ),
    );
  }
}