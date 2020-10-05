import 'package:flutter/cupertino.dart';

class BaseModel with ChangeNotifier {
  bool loading = false;

  void load() {
    this.loading = true;
    notifyListeners();
  }

  void loaded() {
    this.loading = false;
    notifyListeners();
  }
}
