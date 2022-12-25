import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ArtisanController {
  static var url = "http://localhost:3000/";

  static Future<int> createArtisan(
    String name,
    String password,
    String email,
    String username,
    String telephone,
    String siret,
    String adress,
    String entreprise,
  ) async {
    var response = await http.post(Uri.parse("${url}addArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'username': username,
          'telephone': telephone,
          'email': email,
          'picture': 'n',
          'siret': siret,
          'mobilite': "n",
          'adress': adress,
          'domaine': "n",
          'entreprise': entreprise,
          'note': "n",
          'chantier': "n",
          'password': password,
        }));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.statusCode;
  }

  static Future<int> authenticate(String email, String password) async {
    var response = await http.post(Uri.parse("${url}authenticateArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    print('Response status 200: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.statusCode;
  }

  static Future<void> getInfo(String token) async {
    var response = await http
        .post(Uri.parse("${url}getinfoArtisan"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer : ${token}'
    });
  }
}
