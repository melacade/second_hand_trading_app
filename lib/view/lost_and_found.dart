import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/model/security_problems.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';
class LostAndFound extends StatefulWidget {
  @override
  _LostAndFoundState createState() => _LostAndFoundState();
}

class _LostAndFoundState extends State<LostAndFound> {
  String _account;

  void _onSubmit(){

    if (_account == null|| _account.length < 5 || _account == ''|| _account.length>10|| _account.contains(" ")) {
      _showMessageDialog('Account length should be between 5 and 10, and does not contain spaces');
      return;
    }
    UserApi.checkSecurityProblem(account: _account,success: (json) {
      var problems = SecurityProblems.fromJson(json);
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.resetAccount,arguments: {
        'action' : Consts.changePassword,
        'problems' : problems,
        'account' : _account
      });
    },fail: (message,code){
      if(code == -1){
        _showMessageDialog('The account '+_account+' does not exist!');
      }else{

      }
    });
  }
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
          "Lost and Found",
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
            Text("Please enther account"),
            Expanded(
              child: TextField(
              
                maxLines: 1,
                style: TextStyle(fontSize: 50.ssp),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please input a account',
                  icon: new Icon(
                    Icons.account_box,
                    color: Colors.grey,
                  ),
                ),
                
                onChanged: (value) {
                  _account = value;
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
                            ? "Cancle"
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