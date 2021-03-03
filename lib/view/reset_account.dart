import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/model/security_problems.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class ResetAccount extends StatefulWidget {
  ResetAccount({this.args});
  var args;
  @override
  _ResetAccountState createState() => _ResetAccountState();
}

class _ResetAccountState extends State<ResetAccount> {
  String _account;
  String _id;

  void changePassword() {
    Navigator.pushNamed(context, Routes.resetPassword);
  }

  void _showMessage(String message) {
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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void changeSecurityProblem() {
    Navigator.pushNamed(context, Routes.addNewSecurityProblem);
  }

  void _onSubmit() {

    for (int i = 0; i < 3; i++) {
      if (widget.args['problems']?.data[i]?.answer == null) {
        _showMessage("Please fill the problems completly" );
        return;
      }
    }

    UserApi.validateProblems(widget.args['problems'].data, success: (data) {
      if(data){
        switch (widget.args['action']) {
        case Consts.changePassword:
          log("change pwd");
          break;
        case Consts.changeSecurityProblem:
          break;
        default:
      }
      }else{
        _showMessage("There are one or more wrong security problems!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Auth token",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProviderWidget<UserViewModel>(
                  model: UserViewModel.curr,
                  exist: true,
                  onReady: (model) => {
                    model.loadData(),
                  },
                  builder: (context, model, child) {
                    var id = UserViewModel.userBean?.data?.id;
                    if (id == null) {
                      return TextField(
                        onChanged: (value) {
                          _account = value;
                        },
                      );
                    } else {
                      _id = id;
                      return Padding(
                          padding: EdgeInsets.fromLTRB(0, 10.ssp, 0, 0));
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.args['problems'].data[0].question,
                    style: TextStyle(fontSize: 50.ssp),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                  widget.args['problems'].data[0].answer = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.args['problems'].data[1].question,
                    style: TextStyle(fontSize: 50.ssp),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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

                  widget.args['problems'].data[1].answer = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.args['problems'].data[2].question,
                    style: TextStyle(fontSize: 50.ssp),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                  widget.args['problems'].data[2].answer = value;
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
                            : "Cancel");
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
                    child: Text("Submit"),
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
