import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/view/components/saling_goods_card.dart';

class MySalingGoods extends StatefulWidget {
  @override
  _MySalingGoodsState createState() => _MySalingGoodsState();
}

class _MySalingGoodsState extends State<MySalingGoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My saling",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60.ssp,color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.red, //指示器颜色，默认ThemeData.accentColor
        backgroundColor: Colors.white, //指示器背景颜色，默认ThemeData.canvasColor
        notificationPredicate:
            defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
        child: ListView.builder(
          itemBuilder: (context, index) {
            return SalingGOodsCard(goodsName: "test",commentCount: 32, defaultImage: "/test",saled: 20,left: 10,);
          },
          itemCount: 2,
        ),
        onRefresh: () async{},
      ),
    );
  }
}
