import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_hand_trading_app/api/user_api.dart';
import 'package:second_hand_trading_app/model/user.dart';
import 'package:second_hand_trading_app/utils/database/database_utils.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  int _counter = 5;
  Timer _timer;


  @override
  void initState() {
    super.initState();

    // transfer to the main page after 2 seconds
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) async {
      this?.setState(() {
        _counter -= 1;
      });
      if (_counter == 0) {
        await _cheak();
        Navigator.pushReplacementNamed(context, "/main/mainPage");
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  Future<Void> _cheak() async{
    DatabaseUtils dbUtil = new DatabaseUtils();
        var findCurUSer = await dbUtil.findCurUSer();
        if (findCurUSer?.token != null) {
          await UserApi.login("", "", findCurUSer.token,(json) async {
            var userBean = UserBean.fromJson(json);
            log(userBean.message);
            log("${userBean.code}");
            if (userBean.code != 200) {
              await dbUtil.deleteUser();
              if(UserViewModel.curr?.hasListeners){
                UserViewModel.curr?.loaded();
              }
            }
          }, (reason, code) {});
        }
        return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          OutlineButton(
            color: Colors.transparent,
            shape: CircleBorder(),
            splashColor: Colors.grey,
            child: Text("${this._counter} 跳过"),
            onPressed: ()  async{
              _timer?.cancel();
              _timer = null;
              await _cheak();
              Navigator.pushReplacementNamed(context, "/main/mainPage");
            },
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/timg.jpg')),
              Text(
                "西南交通大学二手交易平台",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.ssp,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
