import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/model/user.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      UserViewModel.curr.uploadAvatar(
        _image,
        success: (json) {},
      );
    }
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        log("no img selected!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "Modify personal information",
          style: TextStyle(fontSize: 60.ssp),
        ),
      ),
      body: ListView(
        children: [
          ProviderWidget<UserViewModel>(
            model: UserViewModel.curr,
            onReady: (model) {
              model.loadData();
            },
            exist: true,
            builder: (context, model, child) {
              return _topHeader(UserViewModel.userBean);
            },
          ),
          ProviderWidget<UserViewModel>(
            model: UserViewModel.curr,
            onReady: (model) {
              model.loadData();
            },
            exist: true,
            builder: (context, model, child) {
              return _actionList(UserViewModel.userBean);
            },
          ),
          Container(
            height: 0.5.hp,
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text("Save changes"),
              color: Colors.black12,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _actionList(UserBean user) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      child: Column(
        children: <Widget>[
          _myListTitle('User nickname', user),
          _myListTitle('Phone number', user),
        ],
      ),
    );
  }

  Widget _myListTitle(String title, UserBean user) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: TextField(
        decoration: InputDecoration(
          icon:
              title == "User nickname" ? Icon(Icons.person) : Icon(Icons.phone),

          // labelText: title,
          // hintText: "hintText",
          prefixText: title + " ",
        ),
        controller: TextEditingController(
            text: title == "User nickname" ? user.data.name : user.data.phone),
      ),
    );
  }

  Widget _topHeader(UserBean user) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 19),
              child: Material(
                shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.green, width: 2, style: BorderStyle.solid),
                ),
                child: IconButton(
                  icon: CircleAvatar(
                    radius: 50,
                    backgroundImage: user.data == null ||
                            user.data.avator == "default"
                        ? AssetImage('assets/images/default.jpg')
                        : NetworkImage("${Http.baseUri}${user.data.avator}"),
                  ),
                  iconSize: 100,
                ),
              )),
          FlatButton(
            onPressed: () {
              getImage();
            },
            child: Text("Change the avatar"),
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
