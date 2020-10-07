import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/utils/image_loader.dart';

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
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      this?.setState(() {
        _counter -= 1;
      });
      print(_counter);
      if (_counter == 0) {
        Navigator.pushReplacementNamed(context, "/main/mainPage");
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          OutlineButton(
            color: Colors.transparent,
            shape: CircleBorder(),
            splashColor: Colors.grey,
            child: Text("${this._counter} 跳过"),
            onPressed: () => {
              _timer?.cancel(),
              _timer = null,
              Navigator.pushReplacementNamed(context, "/main/mainPage")
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
              ImageLoader(
                  "https://bkimg.cdn.bcebos.com/pic/3bf33a87e950352a317"
                  "a4b9e5e43fbf2b2118b09?x-bce-process=image/watermark,"
                  "image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5",
                  400),
              Text(
                "西南交通大学二手交易平台",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
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
