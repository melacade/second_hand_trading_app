import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/view/components/address_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/viewmodel/default_address.dart';

class AddressList extends StatefulWidget {
  AddressList({this.select});
  bool select;
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  String _country;
  String _city;
  String _province;
  bool _isDefault;
  String _detail;
  List<dynamic> list = [
    {"country": "add"}
  ];

  void addAddress(context) async {
    _country = "";
    _city = "";
    _province = "";
    _detail = "";
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text("Country: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            _country = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Province: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            _province = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("City: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            _city = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Detail: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            _detail = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text("Submit"),
                      onPressed: () {
                        _onSubmit();
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  void _onSubmit() {
    Map<String, dynamic> m = {
      "country": _country,
      "city": _city,
      "province": _province,
      "detail": _detail
    };
    UserApi.addAddress(m, success: (data) {
      list.removeAt(list.length - 1);
      list.add(data);
      list.add({"country": "add"});
      Navigator.pop(context);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserApi.getAddressList(
      success: (data) {
        list.clear();
        list.addAll(data);
        list.add({"country": "add"});
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address"),
        ),
        body: ProviderWidget<DefaultAddress>(
          model: DefaultAddress(),
          builder: (context, model, child) {
            list = model.list;
            return ListView.builder(
              itemBuilder: (context, index) {
                return list[index]['country'] == 'add'
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(5)),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(10)),
                                Expanded(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    onPressed: () {
                                      addAddress(context);
                                    },
                                    child: Image.asset(
                                      "assets/images/defaultadd.png",
                                      width: 1.wp,
                                      height: 0.2.hp,
                                    ),
                                    focusColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(10))
                              ],
                            )
                          ],
                        ))
                    : AddressCard(
                        list[index]['country'],
                        list[index]['province'],
                        list[index]['city'],
                        list[index]['detail'],
                        select: widget.select,
                        id: list[index]['id'],
                        isDefault: list[index]['isDefault'] == null
                            ? false
                            : list[index]['isDefault'],
                        model: model,
                      );
              },
              itemCount: list.length,
            );
          },
        ));
  }
}
