import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/model/user.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class PersonalCenter extends StatefulWidget {
  @override
  _PersonalCenterState createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "我的",
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
            builder: (context, model, child) {
              return _topHeader(UserViewModel.userBean);
            },
          ),
          _orderType(),
          _actionList()
        ],
      ),
    );
  }

  Future _openModalBottomSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('修改个人资料', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.userInofPage);
                  },
                ),
                ListTile(
                  title: Text('退出登录', textAlign: TextAlign.center),
                  onTap: () {
                    UserViewModel.curr.logOut(
                      success: (data) {
                        Navigator.pop(context);
                      },
                      fail: (reason, code) {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text('取消', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
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
                        color: Colors.green,
                        width: 2,
                        style: BorderStyle.solid)),
                child: IconButton(
                    icon: CircleAvatar(
                      radius: 50,
                      backgroundImage: user.data == null ||
                              user.data.avator == "default"
                          ? AssetImage('assets/images/default.jpg')
                          : NetworkImage("${Http.baseUri}${user.data.avator}"),
                    ),
                    iconSize: 100,
                    onPressed: () {
                      if (user.data == null || user.data.id == null) {
                        Navigator.pushNamed(context, Routes.loginPage);
                      } else {
                        _openModalBottomSheet();
                      }
                    })),
          ),
          Container(
            margin: EdgeInsets.only(top: 9),
            child: Text(user.data == null ? "点击登录" : user.data.name),
          )
        ],
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: 1.wp,
      height: 0.15.hp,
      padding: EdgeInsets.only(top: 19),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 0.2.wp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.library_books,
                  size: 0.05.hp,
                ),
                Text("我的订单")
              ],
            ),
          ),
          Container(
            width: 0.2.wp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.payment,
                  size: 0.05.hp,
                ),
                Text("待付款")
              ],
            ),
          ),
          Container(
            width: 0.2.wp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.card_travel,
                  size: 0.05.hp,
                ),
                Text("待收货")
              ],
            ),
          ),
          Container(
            width: 0.2.wp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.strikethrough_s,
                  size: 0.05.hp,
                ),
                Text("退换/售后")
              ],
            ),
          ),
          Container(
            width: 0.2.wp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 0.05.hp,
                ),
                Text("待评价")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 3),
      child: Column(
        children: <Widget>[
          _myListTitle('收货地址管理'),
          _myListTitle('账户与安全'),
          _myListTitle('优惠券'),
          _myListTitle('联系客服'),
          _myListTitle('关于我们'),
        ],
      ),
    );
  }

  Widget _myListTitle(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.blur_on),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
