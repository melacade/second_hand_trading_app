import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/common/routes.dart';

import 'goods_card.dart';

class GoodsList extends StatefulWidget {
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {
  var _results = [];
  int _currPage = 1;
  bool loading = false;
  bool more = true;
  bool moving = false;
  bool init = true;
  var _controller = ScrollController();

  void _nextPage() {
    _currPage++;
    loading = true;
    GoodsApi.getGoodsByPage(_currPage, 10, success: (data) {
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
    GoodsApi.getGoodsByPage(_currPage, 10, success: (data) {
      _results.addAll(data);
      init = false;
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
        displacement: 40, //指示器显示时距顶部位置
        color: Colors.red, //指示器颜色，默认ThemeData.accentColor
        backgroundColor: Colors.white, //指示器背景颜色，默认ThemeData.canvasColor
        notificationPredicate:
            defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
        child: init
            ? Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text("Refresh"),
                      onPressed: () {
                        GoodsApi.getGoodsByPage(_currPage, 10, success: (data) {
                          _results.clear();
                          _results.addAll(data);
                          init = false;
                          setState(() {});
                        }, fail: (message, code) {});
                      },
                    ),
                  ),
                ],
              )
            : StaggeredGridView.countBuilder(
                controller: _controller,
                padding: EdgeInsets.all(10),
                crossAxisCount: 4,
                itemCount: _results.length,
                physics: AlwaysScrollableScrollPhysics(),
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
                    child: GoodsCard(
                        _results[index]['name'], _results[index]['price'],
                        img: _results[index]['defaultImage'],
                        count: _results[index]['count']),
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
        onRefresh: () async {
          log("refe");
          init = true;
          setState(() {
            
          });
          GoodsApi.getGoodsByPage(_currPage, 10, success: (data) {
            _results.clear();
            _currPage = 1;
            _results.addAll(data);
            init = false;
            setState(() {});
          }, fail: (message, code) {});
        });
  }
}
