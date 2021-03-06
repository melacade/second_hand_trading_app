import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';


class ResetPassword extends StatefulWidget {
  ResetPassword({this.args});
  var args;
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _password1;
  String _password2;
  _onSubmit(){
    if(_password1 == "" || _password1 == null || _password1.length > 11 || _password1.length < 6 ){
      _showMessage("The password length needs to be between 6 and 11",false);
      return;
    }

    if(_password1 != _password2){
      _showMessage("The two passwords are different!",false);
      return;
    }

    UserApi.resetPassword(_password1, account: widget.args['account'],success : (data){
      _showMessage(data, true);
    },fail:(message,code){
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
                if(back){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else{
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
          "Reset Password",
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
            Text("New Password"),
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
                  _password1 = value;
                },
              ),
            ),
            Text("Please enter the password again"),
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
                  _password2 = value;
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
