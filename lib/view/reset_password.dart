import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({this.args});
  var args;
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _oldPassword;
  String _password1;
  String _password2;

  Widget _passwordForm() {
    return Column(children: [
      Row(
        children: [
          Expanded(child: Text("请输入新密码")),
          Expanded(
            child: TextField(
              onChanged: (value) {
                _password1 = value;
              },
            ),
          )
        ],
      ),
      Row(
        children: [
          Expanded(child: Text("请再次输入")),
          Expanded(
            child: TextField(
              onChanged: (value) {
                _password2 = value;
              },
            ),
          )
        ],
      ),
      FlatButton(
        onPressed: () {},
        child: Text("完成"),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("重置密码"),
      ),
      body: widget.args == "problem"
          ? Column(children: [
              _passwordForm(),
            ])
          : Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Text("请输入旧密码"),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _oldPassword = value;
                      },
                    ),
                  )
                ]),
                _passwordForm(),
              ],
            ),
    );
  }
}
