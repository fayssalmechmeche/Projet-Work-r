import 'dart:convert';
import 'package:http/http.dart' as http;

class NodeJSManager {
  static var url = "http://10.0.2.2:3000/";


  static Future<int> createUser(String name,String password) async {
  var response = await http.post(Uri.parse("${url}adduser"),headers:<String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },body: jsonEncode(<String, String>{
  'name': name,'password':password}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response.statusCode;
  }
  static Future<int> authenticate(String name,String password) async {

    var response = await http.post(Uri.parse("${url}authenticate"),headers:<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String, String>{
      'name': name,'password':password}));

   // print('Response status: ${response.statusCode}');
   // print('Response body: ${response.body}');

    return response.statusCode;
  }
  static Future<int> update(String name,String password) async{
    var response = await http.post(Uri.parse("${url}update"),headers:<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String, String>{
      'name': name,'password':password}));

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    return response.statusCode;

  }
}