import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:second_hand_trading_app/viewmodel/add_img_view_model.dart';

class ShowImages extends StatefulWidget {
  ShowImages(this.model, {this.index = 0});
  int index;
  AddImgViewModel model;
  @override
  _ShowImagesState createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int i) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(File(widget.model.img[i])),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                  );
                },
                itemCount: widget.model.img.length - 1,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
                pageController: PageController(initialPage: widget.index),
                onPageChanged: (page) {
                  widget.index = page;
                },
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  widget.model.changeDefault(widget.index);
                  setState(() {
                    
                  });
                },
                child: Text("Seteing as main image"),
              ),
            ),
            FlatButton(onPressed: () {
              widget.model.removeImage(widget.index);
              if(widget.model.img.length - 1 == 0){
                Navigator.pop(context);
              }
              if(widget.index >= widget.model.img.length-1){
                widget.index = widget.model.img.length - 2;
              }
              setState(() {
                
              });
            }, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
