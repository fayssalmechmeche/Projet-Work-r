import 'package:http/http.dart' as http;
import 'dart:convert';

const baseURL = "http://localhost:3000/";

class NodeJSManager {
  static Future<String> createUser() async {
    var url = "http://localhost:3000/";
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }
}
