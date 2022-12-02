import 'dart:convert';
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
      String mobilite,
      String adress,
      String domaine,
      String entreprise,
      String note,
      String chantier) async {
    var response = await http.post(Uri.parse("${url}addArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'password': password,
          'email': email,
          'username': username,
          'telephone': telephone,
          'siret': siret,
          'mobilite': mobilite,
          'adress': adress,
          'domaine': domaine,
          'entreprise': entreprise,
          'chantier': chantier,
          'note': note
        }));
    print('Response status 200: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.statusCode;
  }

  static Future<int> authenticate(String email, String password) async {
    var response = await http.post(Uri.parse("${url}authenticateArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'password': password}));

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
