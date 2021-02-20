import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class AddNewSecurityProblem extends StatefulWidget {
  @override
  _AddNewSecurityProblemState createState() => _AddNewSecurityProblemState();
}

class _AddNewSecurityProblemState extends State<AddNewSecurityProblem> {
  String _problem1;
  String _problem2;
  String _problem3;
  String _answer1;
  String _answer2;
  String _answer3;

  List<DropdownMenuItem> _items() {
    List<DropdownMenuItem> list = List();
    Consts.securityProblems.forEach((element) {
      list.add(new DropdownMenuItem(child: Text(element), value: element));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "添加安全凭证",
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("问题1"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('请选择'),
                      onChanged: (value) {
                        setState(() {
                          _problem1 = value;
                        });
                      },
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
                  child: Text("问题2"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('请选择'),
                      onChanged: (value) {
                        setState(() {
                          _problem2 = value;
                        });
                      },
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
                  child: Text("问题3"),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: _items(),
                      hint: Text('请选择'),
                      onChanged: (value) {
                        setState(() {
                          _problem3 = value;
                        });
                      },
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
                      Navigator.pushReplacementNamed(context, Routes.mainPage);
                    },
                    child: ProviderWidget<UserViewModel>(
                      model: UserViewModel.curr,
                      onReady: (model) => {model.loadData()},
                      builder: (context, model, child) {
                        return Text(UserViewModel.userBean.data?.id == null
                            ? "跳过"
                            : "取消");
                      },
                    ),
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      UserApi.addNewSecurityProblem(
                          _problem1,
                          _problem2,
                          _problem3,
                          _answer1,
                          _answer2,
                          _answer3, success: (data) {
                        Navigator.pushReplacementNamed(
                            context, Routes.mainPage);
                      }, fail: (message, code) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text('提示'),
                              content: new Text(message),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("ok"),
                                  onPressed: () {
                                    Navigator.popUntil(context, (route){
                                      log(route.settings.name);
                                      return route.settings.name == Routes.mainPage;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    child: Text("完成"),
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
