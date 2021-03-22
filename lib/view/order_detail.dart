import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';
import 'package:second_hand_trading_app/view/components/address_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail(this.orderId);
  var orderId;
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var data;

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('Tips'),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoodsApi.getOrderInfo(widget.orderId, success: (json) {
      data = json;
      setState(() {});
    });
  }

  void _onSubmit() {
    GoodsApi.payOrder(widget.orderId, success: (data) {
      _showMessageDialog(data);
    },fail : (message,code){
      _showMessageDialog(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          data == null ? "Loading" : data['goodsInfo']['name'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey,
      body: data == null
          ? Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text("Refresh"),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 0.5.wp,
                        height: 0.4.hp,
                        child: Image.network(
                            Http.baseUri + data['goodsInfo']['defaultImage']),
                      ),
                    ),
                    Expanded(
                      child: Text(data['goodsInfo']['name']),
                    )
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(child: Text("Saler: ")),
                      Expanded(
                          child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                data['owner']['avator'] == "default"
                                    ? AssetImage("assets/images/default.jpg")
                                    : NetworkImage(
                                        Http.baseUri + data['owner']['avator']),
                          ),
                          Text("  ${data['owner']['name']}"),
                        ],
                      )),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AddressCard(
                          data['address']['country'],
                          data['address']['province'],
                          data['address']['city'],
                          data['address']['detail'],id: data['address']['id'],),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Pay by:"),
                    ),
                    Expanded(
                      child: Text("Mock"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Order ID: "),
                    ),
                    Expanded(
                      child: Text(data['order']['id']),
                    )
                  ],
                )
              ],
            ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    _onSubmit();
                  },
                  child: Text(
                    "Cancel order",
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
              ],
            ),
          ),
          Expanded(
              child: Text(
            data == null
                ? "Total: ￥ 0"
                : "Total: ￥ ${data['goodsInfo']['price'] * data['order']['count']}",
            style: TextStyle(color: Colors.red),
          )),
          RaisedButton(
            onPressed: () {
              _onSubmit();
            },
            child: Text(
              "Pay",
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
