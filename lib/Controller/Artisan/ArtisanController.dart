import 'dart:convert';
import 'package:http/http.dart' as http;

class ArtisanController {
  static var url = "http://localhost:3000/";

  static Future<int> createArtisan(
      String name,
      String password,
      String mail,
      String username,
      String telephone,
      String siret,
      String mobilite,
      String adress,
      String domaine,
      String entreprise) async {
    var response = await http.post(Uri.parse("${url}addArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'password': password,
          'mail': mail,
          'username': username,
          'telephone': telephone,
          'siret': siret,
          'mobilite': mobilite,
          'adress': adress,
          'domaine': domaine,
          'entreprise': entreprise,
          'chantier': [].toString(),
          'note': 0.toString()
        }));

    return response.statusCode;
  }

  static Future<int> authenticate(String mail, String password) async {
    var response = await http.post(Uri.parse("${url}authenticateArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'mail': mail, 'password': password}));

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
