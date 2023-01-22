import 'package:flutter/foundation.dart';

class GlobalData with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  Map<String, dynamic> user = {};

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void setUser(Map<String, dynamic> user) {
    this.user = user;
    notifyListeners();
  }
}
