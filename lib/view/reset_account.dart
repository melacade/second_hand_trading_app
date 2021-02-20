import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class ResetAccount extends StatefulWidget {
  ResetAccount({this.args});
  var args;
  @override
  _ResetAccountState createState() => _ResetAccountState();
}

class _ResetAccountState extends State<ResetAccount> {
  String _problem1;
  String _problem2;
  String _problem3;
  String _answer1;
  String _answer2;
  String _answer3;
  String _account;
  


  String _id;

  void changePassword(){
    Navigator.pushNamed(context, Routes.resetPassword);
  }

  void changeSecurityProblem(){
    Navigator.pushNamed(context, Routes.addNewSecurityProblem);
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
                ProviderWidget(
                  model: UserViewModel(),
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
                      Text("请输入密保问题");
                      _id = id;
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("问题1"),
                ),
                Expanded(
                  flex: 4,
                  child: Text(_problem1),
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
                  child: Text(_problem2),
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
                onChanged: (value){
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
                  child: Text(_problem3),
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
                      model: UserViewModel(),
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
                      switch (widget.args) {
                        case Consts.changePassword:
                          
                          break;
                          case Consts.changeSecurityProblem:
                          break;
                        default:
                      }
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
