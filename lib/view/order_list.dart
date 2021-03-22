import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/view/components/order_card.dart';

class OrderList extends StatefulWidget {
  OrderList({this.status = 0});
  var status;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<dynamic> data = [];
  int page = 1;
  int count = 10;
  bool moving = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.status) {
      case 0:
        GoodsApi.getOrders(
          page,
          count,
          success: (json) {
            data.addAll(json);
            setState(() {});
          },
        );
        break;
      case 1:
        GoodsApi.getPayingOrders(
          page,
          count,
          success: (json) {
            data.addAll(json);
            setState(() {});
          },
        );
        break;
      case -1:
        GoodsApi.getReturnOrders(
          page,
          count,
          success: (json) {
            data.addAll(json);
            setState(() {});
          },
        );
        break;
      case 2:
        GoodsApi.getReceivingOrders(
          page,
          count,
          success: (json) {
            data.addAll(json);
            setState(() {});
          },
        );
        break;
      default:
        GoodsApi.getOrders(
          page,
          count,
          success: (json) {
            data.addAll(json);
            setState(() {});
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Listener(
            onPointerUp: (up) {
              if (!moving) {
                Navigator.pushNamed(
                  context,
                  Routes.orderDetail,
                  arguments: data[index]['id'],
                );
              }
              moving = false;
            },
            onPointerMove: (move) {
              moving = true;
            },
            child: OrderCard(
              id: data[index]['id'],
              date: data[index]['date'],
              price: data[index]['price'],
              image: data[index]['image'],
              status: data[index]['status'],
              name: data[index]['name'],
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
