import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/utils/image_loader.dart';

class OrderCard extends StatefulWidget {
  OrderCard(
      {this.id, this.date, this.image, this.price, this.name, this.status});
  String id;
  DateTime date;
  String image;
  double price;
  String name;
  int status;
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      //z轴的高度，设置card的阴影
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        height: .15.hp,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: ImageLoader(
                  "http://10.0.2.2:8080" + widget.image,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(widget.name,
                              style: TextStyle(fontSize: 50.ssp)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "￥ ${widget.price}",
                            style:
                                TextStyle(color: Colors.red, fontSize: 50.ssp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                widget.status == 0
                    ? "Unpaid"
                    : widget.status == 1
                        ? "待收货"
                        : widget.status == -1
                            ? "已取消"
                            : "已完成",
                style: TextStyle(
                    color: widget.status == 0
                        ? Colors.grey
                        : widget.status == 1
                            ? Colors.brown
                            : widget.status == -1
                                ? Colors.yellow
                                : Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
