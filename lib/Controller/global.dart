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

  String getEmail() {
    return user["email"];
  }

  String getName() {
    return user["name"];
  }

  String getTelephone() {
    return user["telephone"];
  }

  String getAdress() {
    return user["adress"];
  }

  String getCity() {
    if (user["city"] == null)
      return "inconnu";
    else
      return user["city"];
  }

  String getPostalCode() {
    if (user["postalCode"] == null)
      return "inconnu";
    else
      return user["postalCode"];
  }
}
