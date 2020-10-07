import 'package:flutter/material.dart';

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
              onTap: () {},
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
