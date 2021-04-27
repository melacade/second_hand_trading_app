import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_trading_app/api/goods_api.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/view/components/my_goods_labels.dart';
import 'package:second_hand_trading_app/viewmodel/add_img_view_model.dart';
import 'package:second_hand_trading_app/viewmodel/label_view_model.dart';

class AddNewGoods extends StatefulWidget {
  static List labels = [];
  @override
  _AddNewGoodsState createState() => _AddNewGoodsState();
}

class _AddNewGoodsState extends State<AddNewGoods> {
  List<String> _imgs;
  int _newPercentage = 50;
  String _info;

  String _name;
  double _realPrice;
  double _transCosts;
  double _price;
  LabelViewModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    AddNewGoods.labels = [];
  }

  Future _openModalBottomSheet(LabelViewModel model) async {
    String name = "";
    String info = "";
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(child: Text("Lable Name: ")),
                    Expanded(child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Lable Info: ")),
                    Expanded(child: TextField(
                      onChanged: (value) {
                        info = value;
                      },
                    ))
                  ],
                ),
                Center(
                  child: TextButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (name.length < 2) {
                        return;
                      }
                      model.addLabel(name, info, success: () {
                        Navigator.pop(context);
                      },);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _onSubmit(LabelViewModel model) {
    Map<String, dynamic> detail = {
      "newPercentage": _newPercentage,
      "info": _info,
      "name": _name,
      "labels": model.selected.toList(),
      "originalPrice": _realPrice,
      "price": _price,
      "transCosts": _transCosts
    };
    GoodsApi.addNewGoods(_imgs.sublist(0, _imgs.length - 1), detail,
        success: (json) {
      Navigator.pop(context);
    });
  }

  final picker = ImagePicker();
  Future<String> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  Widget getItemContainer(String item, AddImgViewModel model, int index) {
    return Container(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          if (item == "add") {
            getImage().then((value) {
              if (value == null) {
                return;
              }
              model.addImage(value);
            });
          } else {
            Navigator.pushNamed(context, Routes.showImages,
                arguments: {'model': model, 'index': index});
          }
        },
        icon: item == "add"
            ? Image.asset("assets/images/defaultadd.png")
            : Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  image: new DecorationImage(
                      image: FileImage(File(item)), fit: BoxFit.cover),
                  shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(
                        20.0), // <-- rectangle 时，BorderRadius 才有效
                  ),
                ),
              ),
        iconSize: 200,
        enableFeedback: false,
        focusColor: Colors.white,
        highlightColor: Colors.white,
        splashColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 70.0,
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.yellow;
                }),
                shape: MaterialStateProperty.all(StadiumBorder()),
                minimumSize: MaterialStateProperty.all(Size(40, 10)),
              ),
              onPressed: () {
                _onSubmit(model);
              },
              child: Text(
                "Release",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name of the goods',
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                minLines: 4,
                maxLines: 4,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'Talk about how you feel about using it, how to get started, and why to change hands',
                ),
                onChanged: (value) {
                  _info = value;
                },
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: ProviderWidget<AddImgViewModel>(
              onReady: (model) {
                model.init();
              },
              model: AddImgViewModel(),
              builder: (context, model, child) {
                _imgs = model.img;
                return GridView.builder(
                    itemCount: model.img.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 3,
                        //纵轴间距
                        mainAxisSpacing: 10.0,
                        //横轴间距
                        crossAxisSpacing: 10.0,
                        //子组件宽高长度比例
                        childAspectRatio: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return getItemContainer(model.img[index], model, index);
                    });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.list),
                    Text("Classification / New percentage")
                  ],
                ),
                ProviderWidget<LabelViewModel>(
                  model: LabelViewModel(),
                  onReady: (model) {
                    this.model = model.init();
                  },
                  builder: (context, model, child) {
                    return Row(
                      children: [
                        Container(
                          width: .3.wp,
                          child: Text(
                            "Classification",
                            style: TextStyle(fontSize: 50.ssp),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          width: .5.wp,
                          height: 65.ssp,
                          child: ListView.builder(
                              itemCount: model.labels.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5)),
                                    MyGoodsLabels(
                                      id: model.labels[index]['id'],
                                      labelName: model.labels[index]['name'],
                                      model: model
                                    ),
                                  ],
                                );
                              }),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _openModalBottomSheet(model);
                            })
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "New percentage",
                        style: TextStyle(fontSize: 50.ssp),
                      ),
                    ),
                    TextButton(
                        child:
                            Text("+10", style: TextStyle(color: Colors.black)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          setState(() {
                            _newPercentage += 10;
                            if (_newPercentage >= 90) {
                              _newPercentage = 90;
                            }
                          });
                        }),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "${_newPercentage} %",
                      style: TextStyle(fontSize: 50.ssp),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    TextButton(
                        child: Text(
                          "-10",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          setState(() {
                            _newPercentage -= 10;
                            if (_newPercentage <= 10) {
                              _newPercentage = 10;
                            }
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money),
                    Text("Sale Price / Real Price / Transportation costs")
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Sale Price",
                      style: TextStyle(fontSize: 50.ssp),
                    )),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 50.ssp),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter price',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+\.{0,1}[0-9]{0,2}')), //只输入数字
                          LengthLimitingTextInputFormatter(6) //限制长度
                        ],
                        onChanged: (value) {
                          _price = double.parse(value);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Real Price",
                        style: TextStyle(fontSize: 50.ssp),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 50.ssp),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter price',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+\.{0,1}[0-9]{0,2}')), //只输入数字
                          LengthLimitingTextInputFormatter(6) //限制长度
                        ],
                        onChanged: (value) {
                          _realPrice = double.parse(value);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Transportation Costs",
                      style: TextStyle(fontSize: 50.ssp),
                    )),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 50.ssp),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter costs',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+\.{0,1}[0-9]{0,2}')), //只输入数字
                          LengthLimitingTextInputFormatter(6) //限制长度
                        ],
                        onChanged: (value) {
                          _transCosts = double.parse(value);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
