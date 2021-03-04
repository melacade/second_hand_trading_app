import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class ResetPayment extends StatefulWidget {
  @override
  _ResetPaymentState createState() => _ResetPaymentState();
}

class _ResetPaymentState extends State<ResetPayment> {
  String _password;
  String _payment;
  String _oldPayment;
  void _onSubmit() {
    if (_password == null ) {
      _showMessage("Please input password", false);
      return;
    }
    if (_payment == null || _payment.length != 6) {
      _showMessage("Please fill 6 bits payment password", false);
      return;
    }
    if (_oldPayment == null || _payment.length != 6) {
      _showMessage("Please fill 6 bits payment password", false);
      return;
    }
    if(_payment == _oldPayment){
      _showMessage("The modified password cannot be the same as the previous one", false);
      return;
    }
    UserApi.resetPayment(_password,_oldPayment, _payment,success: (json) {
      _showMessage(json, true);
    },fail: (message,code){
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
          "Add payment",
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
            Text("Password"),
            Expanded(
              child: TextField(
                obscureText: true,
                maxLines: 1,
                style: TextStyle(fontSize: 50.ssp),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please input a password',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                ),
                
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            Text("Old Payment"),
            Expanded(
              child: TextField(
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                style: TextStyle(fontSize: 50.ssp),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please input a password',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  _oldPayment = value;
                },
              ),
            ),
            Text("Payment"),
            Expanded(
              child: TextField(
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                style: TextStyle(fontSize: 50.ssp),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please input a password',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  _payment = value;
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
