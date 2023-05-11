import 'package:flutter/foundation.dart';

class MessageProvider with ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;

  void addMessage(Map<String, dynamic> message) {
    _messages.add(message);
    notifyListeners();
    print("message");
    print(_messages);
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
