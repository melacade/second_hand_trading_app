import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _account;
  String _password1;
  String _password2;
  String _phone;
  String _name;
  String _salt = DateTime.now().toString();
  static final RegExp _phoneReg = new RegExp("[1][3578]\\d{9}");
  final _formKey = new GlobalKey<FormState>();

  void _onSubmit() async{
    final form = _formKey.currentState;
    form.save();

    if (_account == ''||_account.length < 5 || _account.length>10|| _account.contains(" ")) {
      _showMessageDialog('账号长度需要在5到10之间，且不包含空格');
      return;
    }
    if(_phone == ''|| !_phoneReg.hasMatch(_phone)){
      _showMessageDialog('手机号不合法');
      return;
    }
    if(_name == ''|| _name.length < 3 || _name.length > 10 ){
       _showMessageDialog('昵称长度需要在3到10之间，切不包含空格');
      return;
    }
    if (_password1 == ''|| _password1.length < 6 || _password1.length > 11) {
      
      _showMessageDialog('密码长度需要在6到11之间');
      
      return;
    }
    if(_password2 == ''|| _password2 != _password1){
     _showMessageDialog('两次输入的密码不一致');
      return;
    }
    
    var userViewModel = UserViewModel.curr;
    userViewModel.register(_account,_phone,_name,_password1,_salt,success: (json) {
      Navigator.popUntil(context, (route){
        return route.settings.name == Routes.mainPage;
      });
      Navigator.pushNamed(context, Routes.addNewSecurityProblem);
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

  Widget _showAccountInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入帐号',
            icon: new Icon(
              Icons.account_box,
              color: Colors.grey,
            )),
        onSaved: (value) => _account = value.trim(),
      ),
    );
  }

  Widget _showNametInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入昵称',
            icon: new Icon(
              Icons.emoji_people,
              color: Colors.grey,
            )),
        onSaved: (value) => _name = value.trim(),
      ),
    );
  }

  Widget _showPhonetInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入手机号',
            icon: new Icon(
              Icons.phone_android,
              color: Colors.grey,
            )),
        onSaved: (value) => _phone = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
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
        onSaved: (value) => _password1 = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 15.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 50.ssp),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请再次输入密码',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => _password2 = value.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "西南交通大学二手交易平台",
          style: TextStyle(fontSize: 50.ssp,color: Colors.black),
          //textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            
              height: 0.2.hp,
              child: Image(image: AssetImage('assets/images/timg.jpg')),
            ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 0.7.wp,
                        height: 0.07.hp,
                        child: _showAccountInput()),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Container(
                        width: 0.7.wp,
                        height: 0.07.hp,
                        child: _showPhonetInput()),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Container(
                        width: 0.7.wp,
                        height: 0.07.hp,
                        child: _showNametInput()),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Container(
                        width: 0.7.wp,
                        height: 0.07.hp,
                        child: _showPasswordInput1()),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Container(
                        width: 0.7.wp,
                        height: 0.07.hp,
                        child: _showPasswordInput2()),
                  Container(
                    width:0.7.wp,
                    child:FlatButton(onPressed: (){
                      _onSubmit();
                    },color: Colors.pink, child: Text("注册")),
                  )
                  ],
                ),
              ),
            
            ),
          ),
        ],
      ),
    );
  }
}
