import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArtisanController {
  static var url = "http://localhost:3000/";

  // crea artisan
  static Future<int> createArtisan(
    String name,
    String lastname,
    String password,
    String email,
    String username,
    String telephone,
    String siret,
    String mobilite,
    String adress,
    String domaine,
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
          'picture': 'null',
          'siret': siret,
          'mobilite': mobilite,
          'adress': adress,
          'domaine': domaine,
          'entreprise': entreprise,
          'note': "0",
          'chantier': "null",
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

  // authentification artisan
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

  // get info by token artisan
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

  // update artisan
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

  // get work by state artisan
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

  // get All Artisan
  static Future<Map<String, dynamic>> getAllArtisan() {
    return http.get(Uri.parse("${url}getAllArtisan"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).then((http.Response response) {
      print("getAllArtisan réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  // get recent Artisan
  static Future<Map<String, dynamic>> getRecentArtisan() {
    return http
        .get(Uri.parse("${url}getRecentArtisan"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).then((http.Response response) {
      print("getRecentArtisan réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  // get Work By Artisan
  static Future<Map<String, dynamic>> getChantierById(int artisanId) async {
    print(artisanId.toString());
    var response = await http.get(
      Uri.parse("${url}getAllChantiersByArtisan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanId.toString()
      },
    );

    if (response.statusCode == 200) {
      print("getChantierById réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("getChantierById échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
