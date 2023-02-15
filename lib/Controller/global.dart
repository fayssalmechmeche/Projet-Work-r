import 'dart:io';

import 'package:flutter/foundation.dart';

class GlobalData with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  Map<String, dynamic> user = {};

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void setUser(Map<String, dynamic> user, int role) {
    this.user = user;
    this.user['role'] = role;
    notifyListeners();
  }

  String getEmail() {
    return user["email"];
  }

  int getId() {
    return user["_id"];
  }

  String getPassword() {
    return user["password"];
  }

  String getUsername() {
    return user["username"];
  }

  int getRole() {
    return user['role'];
  }

  String getName() {
    return user["name"];
  }

  String getLastName() {
    return user["lastname"];
  }

  String getPhone() {
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
