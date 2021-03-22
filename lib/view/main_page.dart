import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/view/ListPage.dart';
import 'package:second_hand_trading_app/view/add_new_security_problem.dart';
import 'package:second_hand_trading_app/view/components/goods_list.dart';
import 'package:second_hand_trading_app/view/index.dart';
import 'package:second_hand_trading_app/view/my_saling_goods.dart';
import 'package:second_hand_trading_app/view/personal_center.dart';
import 'package:second_hand_trading_app/view/register_page.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
        _selectedIndex = index;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: SearchBar(),
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Index(),
          ListPage(2),
          MySalingGoods(),
          PersonalCenter(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                IconButton(
                    icon: Icon(Icons.home),
                    color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                    onPressed: (){
                        _onItemTapped(0);
                    },
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                    onPressed: (){
                        _onItemTapped(1);
                    },
                ),
                
                SizedBox(width: 50,),
                
                IconButton(
                    icon: Icon(Icons.photo_filter),
                    color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                    onPressed: (){
                        _onItemTapped(2);
                    },
                ),
                IconButton(
                    icon: Icon(Icons.face),
                    color: _selectedIndex == 3 ? Colors.red : Colors.grey,
                    onPressed: (){
                        _onItemTapped(3);
                    },
                ),
            ],
        ),
    ),
    floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.red,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Icon(Icons.add)
            ]
        ),
        onPressed: (){
            if(UserViewModel.userBean.data.id !=null){
              Navigator.pushNamed(context, Routes.addNewGoods);
            }else{
              Navigator.pushNamed(context, Routes.loginPage);
            }
        },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
