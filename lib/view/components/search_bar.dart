import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/common/routes.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchAdvice;
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                isDense: true,
                hintText:
                    this._searchAdvice == null ? "搜索" : this._searchAdvice,
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.searchPage);
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
