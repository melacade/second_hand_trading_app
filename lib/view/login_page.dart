import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

import 'components/login_animation.dart';
import 'components/login_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  String _userID;
  String _password;
  bool _isChecked = true;
  bool _isLoading = true;
  bool _isLogined = false;
  IconData _checkIcon = Icons.check_box;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    _loginButtonController.addListener(() {
      if(_loginButtonController.isCompleted){
        setState(() {
          animationStatus = 0;
        });
      }
     });
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      _onLogin();
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
      
    } on TickerCanceled {}
  }

  final _formKey = new GlobalKey<FormState>();

  void _changeFormToLogin() {
    _formKey.currentState.reset();
  }

  void _onLogin() async{
    final form = _formKey.currentState;
    form.save();

    if (_userID == '') {
      _showMessageDialog('账号不可为空');
      _loginButtonController.stop();
       
      return;
    }
    if (_password == '') {
      
      _showMessageDialog('密码不可为空');
      _loginButtonController.stop();
      return;
    }
    var userViewModel = UserViewModel.curr;
    userViewModel.login(_userID, _password,"",success: (json) {
      Navigator.pop(context);
    },fail: (reason, code) {
      _showMessageDialog('账号或密码错误');
    });
    

  }

  void _showMessageDialog(String message) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入帐号',
            icon: new Icon(
              Icons.email,
              color: Colors.grey,
            )),
        onSaved: (value) => _userID = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入密码',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: const Text('登录'),
          leading: TextButton(
              onPressed: null,
              child: Text(
                "注册",
                style: TextStyle(color: Colors.black),
              )),
          trailing: TextButton(
            child: Text(
              "找回",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 0.01.hp),
              height: 0.3.hp,
              child: Image(image: AssetImage('assets/images/timg.jpg')),
            ),
            Form(
              key: _formKey,
              child: Container(
                height: 0.23.hp,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 0.7.wp,
                          height: 0.1.hp,
                          child: _showEmailInput()),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      Container(
                          width: 0.7.wp,
                          height: 0.1.hp,
                          child: _showPasswordInput()),
                    ],
                  ),
                ),
              ),
            ),
            animationStatus == 0
                ? new Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: new InkWell(
                        onTap: () {
                          setState(() {
                            animationStatus = 1;
                          });
                          _playAnimation();
                        },
                        child: new SignIn()),
                  )
                : new StaggerAnimation(
                    buttonController: _loginButtonController.view),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 50, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(_checkIcon),
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {
                          _isChecked = !_isChecked;
                          if (_isChecked) {
                            _checkIcon = Icons.check_box;
                          } else {
                            _checkIcon = Icons.check_box_outline_blank;
                          }
                        });
                      }),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '我已经详细阅读并同意',
                            style: TextStyle(
                                color: Colors.black, fontSize: 50.ssp),
                            children: <TextSpan>[
                          TextSpan(
                              text: '《隐私政策》',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: '和'),
                          TextSpan(
                              text: '《用户协议》',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))
                        ])),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
