import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/view/components/goods_card.dart';

class SearchBody extends StatefulWidget {
  SearchBody({this.search});
  var search;

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  var _results = [];
  int _currPage = 1;
  bool loading = false;
  bool more = true;
  bool moving = false;
  var _controller = ScrollController();

  void _nextPage() {
    _currPage++;
    loading = true;
    GoodsApi.search(widget.search, page: _currPage, success: (data) {
      _results.addAll(data);
      setState(() {});
      loading = false;
      if (data.length <= 10) {
        more = false;
        return;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoodsApi.search(widget.search, success: (data) {
      _results.addAll(data);
      setState(() {});
    }, fail: (message, code) {});
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.red, //指示器颜色，默认ThemeData.accentColor
      backgroundColor: Colors.white, //指示器背景颜色，默认ThemeData.canvasColor
      notificationPredicate:
          defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
      child: StaggeredGridView.countBuilder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        padding: EdgeInsets.all(10),
        crossAxisCount: 4,
        itemCount: _results.length,
        itemBuilder: (BuildContext context, int index) {
          return Listener(
            onPointerUp: (up) {
              if (!moving) {
                Navigator.pushNamed(this.context, Routes.goodsDetail,
                    arguments: _results[index]["id"]);
              }
              moving = false;
            },
            onPointerMove: (move) {
              moving = true;
            },
            child: GoodsCard(_results[index]['name'], _results[index]['price'],
                img: _results[index]['defaultImage'],
                count: _results[index]['count']),
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      onRefresh: () async {
        GoodsApi.search(widget.search, success: (data) {
          _currPage = 1;
          _results.clear();
          _results.addAll(data);
          setState(() {});
        }, fail: (message, code) {});
      },
    );
  }
}
