import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:second_hand_trading_app/view/components/goods_card.dart';

class SearchBody extends StatefulWidget {
  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  var _results = [
    {'title': '2', "img": '/imguser', "price": 200},
    {'title': '2', "img": '/imguser', "price": 200},
    {'title': '2', "img": '/imguser', "price": 200},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: _results.length,
        itemBuilder: (BuildContext context, int index) =>
            GoodsCard('test', 999),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
