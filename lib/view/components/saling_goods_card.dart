import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/utils/image_loader.dart';
class SalingGOodsCard extends StatefulWidget {
  SalingGOodsCard({this.goodsId,this.commentCount,this.defaultImage,this.goodsName,this.left,this.saled});
  int commentCount;
  int goodsId;
  String defaultImage;
  int left;
  int saled;
  String goodsName;


  @override
  _SalingGOodsCardState createState() => _SalingGOodsCardState();
}

class _SalingGOodsCardState extends State<SalingGOodsCard> {
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
                  "http://10.0.2.2:8080" + widget.defaultImage,
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
                          child: Text(widget.goodsName,
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
                            "Left ${widget.left}  Sales ${widget.saled}",
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
                "${widget.commentCount} Comments",
              ),
            ),
          ],
        ),
      ),
    );
  }
}