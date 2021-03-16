import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCard extends StatefulWidget {
  AddressCard(this.country, this.provence, this.city, this.detail, {this.select = false});
  bool select;
  String country;
  String provence;
  String city;
  String detail;
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
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
                        child: Text("Country: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Provence: "),
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(),
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
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: TextButton(
                    child: Text("Submit"),
                  ))
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      //z轴的高度，设置card的阴影
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        height: .2.hp,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text("国家 省份 详细............."),
            ),
            Expanded(
              child: TextButton(
                onPressed: widget.select ? (){} : null,
                child: Text("Select"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: null,
                child: Text("Default"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: null,
                child: Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
