import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArtisanController {
  static var url = "http://localhost:3000/";

  static Future<int> createArtisan(
    String name,
    String lastname,
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
          'lastname': lastname,
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

  // static Future<Map<String, dynamic>> authenticate(
  //     String email, String password) async {
  //   var response = await http.post(Uri.parse("${url}authenticateArtisan"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body:
  //           jsonEncode(<String, String>{'email': email, 'password': password}));

  //   print(jsonDecode(response.body));
  //   return jsonDecode(response.body);
  // }

  static Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    // Envoyer une requête à la fonction Node.js
    var response = await http.post(Uri.parse("${url}authenticateArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    // Vérifier que la réponse a un statut OK
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      print("connexion réussie Artisan Controller");
      print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("connexion échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getInfo(String token) async {
    var response = await http
        .get(Uri.parse("${url}getinfoArtisan"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}'
    });
    if (response.statusCode == 200) {
      print("getInfo réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("getInfo échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> updateArtisan(
    int id,
    String name,
    String lastname,
    String? password,
    String email,
    String username,
    String telephone,
    String adress,
    String entreprise,
  ) async {
    var response = await http.post(Uri.parse("${url}updateArtisan"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'id': id.toString(),
          'name': name,
          'lastname': lastname,
          'password': password,
          'email': email,
          'username': username,
          'telephone': telephone,
          'adress': adress,
          'entreprise': entreprise,
          'picture': 'n',
          'chantier': 'n',
        }));
    print('Response status 200: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      print("connexion réussie Artisan Controller");
      print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("connexion échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getWorkByStatus(state) async {
    var response = await http.get(
      Uri.parse("${url}getWorkByStatus"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'state': state.toString(),
      },
    );

    if (response.statusCode == 200) {
      print("getWorkByStatus réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(response.body);
      return jsonResponse;
    } else {
      print("getWorkByStatus échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
