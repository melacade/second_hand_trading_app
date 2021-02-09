import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool loading = false;

  void load() {
    this.loading = true;
  }

  void loaded() {
    this.loading = false;
    if(this.hasListeners){
      notifyListeners();
    }
  }
}
