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
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    return response.statusCode;
  }

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
      //print("connexion réussie Artisan Controller");
      //print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("connexion échouée Artisan Controller");
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
      //print("getInfo réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getInfo échouée Artisan Controller");
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
          'picture': 'null',
          'chantier': 'null',
        }));
    //print('Response status 200: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      //print("connexion réussie Artisan Controller");
      //print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("connexion échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getArtisanById(int id) async {
    var response = await http.get(
      Uri.parse("${url}getArtisanById"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      //print("getArtisanById réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      //print(response.body);
      return jsonResponse;
    } else {
      //print("getArtisanById échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // get work by state artisan
  static Future<Map<String, dynamic>> getWorkByStatus(
      int state, int artisanID) async {
    var response = await http.get(
      Uri.parse("${url}getWorkByStatus"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'state': state.toString(),
        'artisanID': artisanID.toString(),
      },
    );

    if (response.statusCode == 200) {
      //print("getWorkByStatus réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(response.body);
      return jsonResponse;
    } else {
      //print("getWorkByStatus échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // get All Artisan
  static Future<Map<String, dynamic>> getAllArtisan() {
    return http.get(Uri.parse("${url}getAllArtisan"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).then((http.Response response) {
      //print("getAllArtisan réussie Artisan Controller");
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
      //print("getRecentArtisan réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  // get Work By Artisan
  static Future<Map<String, dynamic>> getChantierById(int artisanId) async {
    //print(artisanId.toString());
    var response = await http.get(
      Uri.parse("${url}getAllChantiersByArtisan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanId.toString()
      },
    );

    if (response.statusCode == 200) {
      //print("getChantierById réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> refuseChantier(
      int artisanID, int workID) async {
    return await http
        .post(Uri.parse("${url}refuseChantier"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'artisanID': artisanID.toString(),
              'workID': workID.toString(),
            }))
        .then((http.Response response) {
      //print("refuseChantier réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  // create a devis for a work
  static Future<Map<String, dynamic>> createDevis(artisanID, particulierID,
      workID, type, category, price, description, pdf) async {
    return await http
        .post(Uri.parse("${url}createDevis"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'artisanID': artisanID.toString(),
              'particulierID': particulierID.toString(),
              'workID': workID.toString(),
              'type': type,
              'category': category,
              'price': price,
              'description': description,
              'pdf': pdf,
            }))
        .then((http.Response response) {
      //print("createDevis réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  static Future<Map<String, dynamic>> getAllDevis(int artisanID) async {
    var response = await http.get(
      Uri.parse("${url}getAllDevis"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanID.toString()
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  ///////////////////////////////  TASK ///////////////////////////////

  static Future<Map<String, dynamic>> getAllTaskFromWork(int workID) async {
    var response = await http.get(
      Uri.parse("${url}getAllTasks"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'workID': workID.toString()
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getAllTaskDoneFromWork(int workID) async {
    var response = await http.get(
      Uri.parse("${url}getAllTasksDone"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'workID': workID.toString()
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getLastTaskDone(int workID) async {
    var response = await http.get(
      Uri.parse("${url}getLastTaskDone"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'workID': workID.toString()
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

static Future<Map<String, dynamic>> endChantier(
      int workID) async {
    var response = await http.post(Uri.parse("${url}endChantier"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'workID': workID.toString(),
        }));
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> createTask(
    String name,
    String type,
    String startAt,
    String endAt,
    String description,
    bool state,
    int workID,
  ) async {
    return await http
        .post(Uri.parse("${url}createTask"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'name': name,
              'type': type,
              'startat': startAt,
              'endat': endAt,
              'description': description,
              'state': state,
              'workID': workID.toString(),
            }))
        .then((http.Response response) {
      //print("createTask réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  static Future<Map<String, dynamic>> updateTask(
    String name,
    String type,
    String startAt,
    String endAt,
    String description,
    bool state,
    int taskID,
  ) async {
    return await http
        .post(Uri.parse("${url}updateTask"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'name': name,
              'type': type,
              'startat': startAt,
              'endat': endAt,
              'description': description,
              'state': state,
              'taskID': taskID,
            }))
        .then((http.Response response) {
      //print("updateTask réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }

  static Future<Map<String, dynamic>> deleteTask(
    int taskID,
  ) async {
    return await http
        .post(Uri.parse("${url}deleteTask"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'taskID': taskID,
            }))
        .then((http.Response response) {
      //print("deleteTask réussie Artisan Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    });
  }


  ///////////////////////////////  CONVERSATION ///////////////////////////////
  ///

  static Future<Map<String, dynamic>> getAllConversationsFromArtisan(
      int artisanID) async {
    var response = await http.get(
      Uri.parse("${url}getAllConversationsFromartisan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanID.toString()
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      //print("getChantierById réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getChantierById échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
