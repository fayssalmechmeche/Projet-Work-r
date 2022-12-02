import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ParticulierController {
  static var url = "http://localhost:3000/";

  static Future<int> createParticulier(
    String name,
    String password,
    String email,
    String username,
    String telephone,
    String city,
    String adress,
    String postalCode,
  ) async {
    var response = await http.post(Uri.parse("${url}addParticulier"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'password': password,
          'email': email,
          'username': username,
          'telephone': telephone,
          'city' : city,
          'adress': adress,
          'postalCode': postalCode,
          'picture': 'n',
          'chantier': 'n',
        }));

    print('Response status 200: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.statusCode;
  }

  static Future<int> authenticate(String email, String password) async {
    var response = await http.post(Uri.parse("${url}authenticateParticulier"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'password': password}));

    return response.statusCode;
  }

  static Future<void> getInfo(String token) async {
    var response = await http
        .post(Uri.parse("${url}getinfoParticulier"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer : ${token}'
    });
  }
}
