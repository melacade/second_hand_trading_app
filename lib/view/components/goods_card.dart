import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/utils/image_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsCard extends StatefulWidget {
  GoodsCard(
    var title,
    var price, {
    this.img,
    this.count,
  }) {
    this.price = price;
    this.title = title;
  }
  var title;
  var price;
  var img;
  var count;
  @override
  _GoodsCardState createState() => _GoodsCardState(price, title, count);
}

class _GoodsCardState extends State<GoodsCard> {
  _GoodsCardState(
    var price,
    var title,
    var count,
  ) {
    this.price = price;
    this.title = title;
    this.count = count;
  }

  var count;
  var price;
  var title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ImageLoader(
              "http://10.0.2.2:8080" + widget.img,
            ),
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 60.ssp,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "￥${price}",
                  style: TextStyle(fontSize: 55.ssp, color: Colors.red),
                ),
              ),
              Expanded(
                child: (count == null || count == 0)
                    ? Text(
                        "${count} left",
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(
                        "${count} left",
                        style: TextStyle(color: Colors.green),
                      ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
