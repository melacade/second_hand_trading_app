import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/utils/image_loader.dart';

class GoodsCard extends StatefulWidget {
  GoodsCard(var title, var price) {
    this.price = price;
    this.title = title;
  }
  var title;
  var price;
  @override
  _GoodsCardState createState() => _GoodsCardState(price, title);
}

class _GoodsCardState extends State<GoodsCard> {
  _GoodsCardState(var price, var title) {
    this.price = price;
    this.title = title;
  }

  var price;
  var title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: ImageLoader(
                "https://ss0.bdstatic.com/"
                "94oJfD_bAAcT8t7mm9GUKT-xh_/timg?"
                "image&quality=100&size=b4000_4000&sec=1602086152&"
                "di=7eae3683929de37a984d808d4efe733b&src="
                "http://bpic.588ku.com/element_origin_min_pic"
                "/01/58/96/43574847c9b0fb2.jpg",
                200),
            color: Colors.red,
          ),
          Container(
            child: Text("title: " + title),
            color: Colors.green,
          ),
          Container(
            child: Text("price：${price}"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
