import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  SearchBar({this.searchText});
  var searchText;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  
  String text;
  TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.text = widget.searchText;
   _controller = new TextEditingController(text: text);
  }
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
                fillColor: Colors.grey[350],
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gapPadding: 10.0),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gapPadding: 10.0),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText:
                    widget.searchText == null ? "Search" : widget.searchText,

              ),
              onChanged: (value) {
                widget.searchText = value;
              },
              cursorColor: Colors.black,
              style: TextStyle(
                fontSize: 70.ssp,
              ),
              
            ),
          ),
          IconButton(
            
            icon: Icon(
              Icons.search,
            ),
            
            onPressed: () {
              Navigator.pushNamed(context, Routes.searchPage,arguments: widget.searchText);
            },
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
