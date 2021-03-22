import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/viewmodel/default_address.dart';

class AddressCard extends StatefulWidget {
  AddressCard(this.country, this.province, this.city, this.detail,
      {this.id, this.select = false, this.isDefault = false, this.model});
  bool isDefault;
  int id;
  bool select;
  String country;
  String province;
  String city;
  String detail;
  DefaultAddress model;
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  String _country;
  String _province;
  String _city;
  String _detail;

  void _setDefault() {
    Map data = {
      'id': widget.id,
      'country': widget.country,
      'province': widget.province,
      'city': widget.city,
      'detail': widget.detail,
      'isDefault': true,
    };
    UserApi.updateAddress(data, success: (data) {
      widget.isDefault = true;
      if(widget.model!=null)
      widget.model.defaultChanged();
      setState(() {});
    });
  }

  void _onSubmit() {
    Map data = {
      'id': widget.id,
      'country': _country,
      'province': _province,
      'city': _city,
      'detail': _detail,
      'isDefault': widget.isDefault,
    };
    UserApi.updateAddress(data, success: (data) {
      widget.country = _country;
      widget.province = _province;
      widget.city = _city;
      widget.detail = _detail;
      setState(() {});
    });
  }

  Future _openModalBottomSheet() async {
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
                          controller:
                              TextEditingController(text: widget.country),
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
                          controller:
                              TextEditingController(text: widget.province),
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
                          controller: TextEditingController(text: widget.city),
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
                          controller:
                              TextEditingController(text: widget.detail),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
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
                flex: 4,
                child: Text(
                  "${widget.country} ${widget.province} ${widget.city}...",
                )),
            Expanded(
              child: TextButton(
                onPressed: widget.select
                    ? () {
                        Navigator.pop(context, {
                          'id': widget.id,
                          'country': widget.country,
                          'province': widget.province,
                          'city': widget.city,
                          'detail': widget.detail,
                          'isDefault': widget.isDefault,
                        });
                      }
                    : null,
                child: Text("Select"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: !widget.isDefault
                    ? () {
                        _setDefault();
                      }
                    : null,
                child: Text("Default"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  _openModalBottomSheet();
                },
                child: Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
