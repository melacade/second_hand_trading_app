import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class ResetSecurityProblems extends StatefulWidget {

  @override
  _ResetSecurityProblemsState createState() => _ResetSecurityProblemsState();
}

class _ResetSecurityProblemsState extends State<ResetSecurityProblems> {
  String _problem1;
  String _problem2;
  String _problem3;
  String _answer1;
  String _answer2;
  String _answer3;
  String _password;
  List<DropdownMenuItem> _items() {
    List<DropdownMenuItem> list = List();
    Consts.securityProblems.forEach((element) {
      list.add(new DropdownMenuItem(child: Text(element), value: element));
    });
    return list;
  }

  void _onSubmit() {
    if (_problem1 == null || _problem2 == null || _problem3 == null) {
      _showMessage("Please select the security question completely!", false);
      return;
    }
    if (_answer1 == null || _answer2 == null || _answer3 == null) {
      _showMessage("Please fill in the questions completely", false);
    }

    UserApi.resetSecurityProblem(
        _problem1, _problem2, _problem3, _answer1, _answer2, _answer3,
        success: (data) {
      _showMessage(data, true);
    }, fail: (message, code) {
      _showMessage(message, false);
    });
  }

  void _showMessage(String message, bool back) {
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
                if (back) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.securityCenter);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Security Problems",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.15.wp, 0, 0, 0),
        alignment: Alignment.topCenter,
        width: .9.wp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: .4.hp,
              image: AssetImage("assets/images/shield.jpeg"),
            ),
            Expanded(child: Text("Password")),
            Expanded(
              child: TextField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Promblem"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('Please select'),
                      onChanged: (value) {
                        setState(() {
                          _problem1 = value;
                        });
                      },
                      isExpanded: true,
                      value: _problem1,
                      style: TextStyle(
                        //设置文本框里面文字的样式
                        color: Color(0xff4a4a4a),
                        fontSize: 40.ssp,
                      ),
                      iconSize: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _answer1 = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Problem"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('Please select'),
                      onChanged: (value) {
                        setState(() {
                          _problem2 = value;
                        });
                      },
                      isExpanded: true,
                      value: _problem2,
                      style: TextStyle(
                        //设置文本框里面文字的样式
                        color: Color(0xff4a4a4a),
                        fontSize: 40.ssp,
                      ),
                      iconSize: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _answer2 = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Problem"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('Please select'),
                      onChanged: (value) {
                        setState(() {
                          _problem3 = value;
                        });
                      },
                      isExpanded: true,
                      value: _problem3,
                      style: TextStyle(
                        //设置文本框里面文字的样式
                        color: Color(0xff4a4a4a),
                        fontSize: 40.ssp,
                      ),
                      iconSize: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _answer3 = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: ProviderWidget<UserViewModel>(
                      model: UserViewModel.curr,
                      onReady: (model) => {model.loadData()},
                      exist: true,
                      builder: (context, model, child) {
                        return Text(UserViewModel.userBean.data?.id == null
                            ? "Skip"
                            : "Cancle");
                      },
                    ),
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      _onSubmit();
                    },
                    child: Text("Finished"),
                    color: Colors.blue,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
