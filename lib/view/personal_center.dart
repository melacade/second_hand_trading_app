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
          "My",
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
                  title: Text('Modify personal data', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.userInofPage);
                  },
                ),
                ListTile(
                  title: Text('Log out', textAlign: TextAlign.center),
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
                  title: Text('Cancel', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void navTo(String title){
    if(UserViewModel.userBean.data.id == null){
       Navigator.pushNamed(context, Routes.loginPage);
       return;
    }
    switch (title) {
            case "Receiving address management":
              break;
            case "Account and security":
              Navigator.pushNamed(context, Routes.securityCenter);
              break;
            case "Coupon":
              break;
            case "Contact customer service":
              break;
            case "About us":
              break;
            default:
              break;
      }
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
            child: Text(user.data == null ? "Click login" : user.data.name),
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
                Text("My order")
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
                Text("To be paid")
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
                Text("To be received")
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
                Text("Return")
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
                Text("Evaluating")
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
          _myListTitle('Receiving address management'),
          _myListTitle('Account and security'),
          _myListTitle('Coupon'), //优惠券
          _myListTitle('Contact customer service'),
          _myListTitle('About us'),
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
        onTap: () {
          navTo(title);
        },
      ),
    );
  }
}
