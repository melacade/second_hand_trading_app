import 'package:second_hand_trading_app/base/base_view_model.dart';

class AddImgViewModel extends BaseViewModel{
  List<String> _images;

  void init(){
    _images = ["add"];
  }

  void addImage(String path){
    _images[_images.length-1] = path;
    _images.add("add");
    loaded();
  }

  void changeDefault(int index){
    if(index >= _images.length - 1 || index < 0) return;
    String temp = _images[0];
    _images[0] = _images[index];
    _images[index] = temp;
    loaded();
  }
  void removeImage(int index){
    if(index >= _images.length - 1 || index < 0) return;
    _images.removeAt(index);
    loaded();
  }

  List<String> get img => _images;
}