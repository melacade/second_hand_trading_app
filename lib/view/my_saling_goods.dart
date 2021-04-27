import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/view/components/saling_goods_card.dart';

class MySalingGoods extends StatefulWidget {
  @override
  _MySalingGoodsState createState() => _MySalingGoodsState();
}

class _MySalingGoodsState extends State<MySalingGoods> {
  List _goods = [];
  int _currPage = 1;
  bool loading = false;
  var _controller = ScrollController();
  bool more = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoodsApi.getSales(_currPage, 10, success: (data) {
      _goods.addAll(data);
    });
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && more && !loading) {
        log("next");
        _nextPage();
        setState(() {});
      }
    });
  }

  void _nextPage() {
    _currPage++;
    loading = true;
    GoodsApi.getSales(_currPage, 10, success: (data) {
      _goods.addAll(data);
      setState(() {});
      loading = false;
      if (data.length < 10) {
        more = false;
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My saling",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60.ssp, color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.red, //指示器颜色，默认ThemeData.accentColor
        backgroundColor: Colors.white, //指示器背景颜色，默认ThemeData.canvasColor
        notificationPredicate:
            defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
        child: ListView.builder(
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SalingGOodsCard(
              goodsName: _goods[index]['name'],
              commentCount: 32,
              defaultImage: _goods[index]['defaultImage'],
              saled: _goods[index]['sales'],
              left: _goods[index]['count'],
            );
          },
          itemCount: _goods.length,
        ),
        onRefresh: () async {
          more = true;
          _currPage = 1;
          GoodsApi.getSales(_currPage, 10, success: (data) {
            _goods.clear();
            _goods.addAll(data);
            setState(() {
              
            });
          });
        },
      ),
    );
  }
}
