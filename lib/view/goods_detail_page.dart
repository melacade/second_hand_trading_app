import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/model/goods_detail.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailPage extends StatefulWidget {
  GoodsDetailPage({this.goodsId});
  var goodsId;
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  GoodsDetail goodsData;
  var _count;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoodsApi.getGoodsInfo(widget.goodsId, success: (data) {
      goodsData = data;
      _count = 1;
      setState(() {});
    }, fail: (message, code) {});
  }

  Future _openModalBottomSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Count   ",
                          style: TextStyle(fontSize: 50.ssp),
                        ),
                      ),
                      TextButton(
                        child:
                            Text("+1", style: TextStyle(color: Colors.black)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          state(() {
                            _count += 1;
                            if (_count >= goodsData.data.goodsInfo.count) {
                              _count = goodsData.data.goodsInfo.count;
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: "${_count}"),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            _count = int.parse(value);
                            if (_count <= 0) {
                              _count = 1;
                              state(() {});
                            }
                            if (_count >= goodsData.data.goodsInfo.count) {
                              _count = goodsData.data.goodsInfo.count;
                              state(() {});
                            }
                          },
                        ),
                      ),
                      TextButton(
                        child:
                            Text("-1", style: TextStyle(color: Colors.black)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          log("${_count}");
                          state(() {
                            _count -= 1;
                            if (_count <= 0) {
                              _count = 1;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "收货地址:",
                            style: TextStyle(fontSize: 50.ssp),
                          )),
                      Expanded(
                          child: Text(
                        "四川省 成都市 成华区...",
                        style: TextStyle(fontSize: 50.ssp),
                      )),
                      TextButton(onPressed: null, child: Text("更改地址")),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Total Price: ",
                        style: TextStyle(fontSize: 50.ssp),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "￥ ${goodsData.data.goodsInfo.price * _count}",
                      style: TextStyle(fontSize: 50.ssp,color: Colors.red),
                    )),
                  ]),
                  Expanded(
                      child: TextButton(
                    onPressed: null,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 50.ssp),
                    ),
                  ))
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: goodsData == null
            ? Text("Loading")
            : Text(
                goodsData.data.goodsInfo.name,
                textAlign: TextAlign.center,
              ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            child: Swiper(
              key: UniqueKey(),
              outer: false,
              autoplay: true,
              autoplayDelay: 2000,
              autoplayDisableOnInteraction: true,
              itemBuilder: (c, i) {
                if (goodsData.data.images != null) {
                  return CachedNetworkImage(
                    imageUrl: Http.baseUri + goodsData.data.images[i].image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  );
                }
              },
              pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0)),
              itemCount: goodsData == null || goodsData.data.images == null
                  ? 0
                  : goodsData.data.images.length,
            ),
            constraints: new BoxConstraints.loose(
              new Size(MediaQuery.of(context).size.width, 180.0),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            color: Colors.grey,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                Text(
                  "Owner: ",
                  style: TextStyle(fontSize: 50.ssp),
                ),
                CircleAvatar(
                  backgroundImage: goodsData == null
                      ? AssetImage("assets/images/default.jpg")
                      : NetworkImage(
                          Http.baseUri + goodsData.data.owner.avator),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Text(
                  goodsData == null ? "Loading" : goodsData.data.owner.name,
                  style: TextStyle(fontSize: 50.ssp),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              Expanded(
                flex: 3,
                child: Text(
                  goodsData == null ? "Loading" : goodsData.data.goodsInfo.name,
                  style: TextStyle(fontSize: 50.ssp),
                ),
              ),
              Expanded(
                child: Text(
                  goodsData == null
                      ? "Loading"
                      : "￥ ${goodsData.data.goodsInfo.price}",
                  style: TextStyle(fontSize: 50.ssp, color: Colors.red),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              Expanded(
                flex: 3,
                child: Text(
                  goodsData == null ? "Loading" : "New Percentage: ",
                  style: TextStyle(fontSize: 50.ssp),
                ),
              ),
              Expanded(
                child: Text(
                  goodsData == null
                      ? "Loading"
                      : "${goodsData.data.goodsInfo.newPercentage} %",
                  style: TextStyle(fontSize: 50.ssp),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Information:",
                style: TextStyle(fontSize: 50.ssp),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
              Expanded(
                child: Text(
                  goodsData == null
                      ? " Loading"
                      : goodsData.data.goodsInfo.info,
                  style: TextStyle(fontSize: 60.ssp),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0))
            ],
          )
        ],
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                    icon: Image(
                      image: AssetImage("assets/images/good.png"),
                    ),
                    onPressed: null),
                IconButton(
                    icon: Image(
                      image: AssetImage("assets/images/comments.png"),
                    ),
                    onPressed: null),
                IconButton(
                    icon: Image(
                      image: AssetImage("assets/images/collect.png"),
                    ),
                    onPressed: null)
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              _openModalBottomSheet();
            },
            child: Text(
              "I want it",
              style: TextStyle(fontSize: 60.ssp, color: Colors.white),
            ),
            color: Colors.red,
            shape: BeveledRectangleBorder(
              side: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          ),
        ],
      ),
    );
  }
}
