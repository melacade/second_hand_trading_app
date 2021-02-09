import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/ListPage.dart';
import 'package:second_hand_trading_app/view/add_new_security_problem.dart';
import 'package:second_hand_trading_app/view/personal_center.dart';
import 'package:second_hand_trading_app/view/register_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: SearchBar(),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          ListPage(1),
          
          AddNewSecurityProblem(),
          PersonalCenter(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('分类'), icon: Icon(Icons.class_)),
          BottomNavigationBarItem(
              title: Text('我的'), icon: Icon(Icons.perm_identity)),
        ],
      ),
    );
  }
}
