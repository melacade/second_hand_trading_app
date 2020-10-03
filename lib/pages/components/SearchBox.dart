import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  SearchBox({Key key}) : super(key: key);

  @override
  _SearchBoxState createState() => new _SearchBoxState();
}

/// State for [ExampleWidget] widgets.
class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget w = new Row(
        children: <Widget>[
          Expanded(child:new TextField(
            controller: _controller,
            decoration: new InputDecoration(
              hintText: 'Type something',
            ),
          ),),
          new RaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text('What you typed'),
                  content: new Text(_controller.text),
                ),
              );
            },
            child: new Text('DONE'),
          ),
        ],
      );

    return w;
  }
}
