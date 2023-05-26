import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/ChantierController/ChantierController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';

class ArtisanController {
  static var url = dotenv.env['DB_HOST'];

  static Future<Map<String, dynamic>> checkSiretExists(String siret) async {
    final token = dotenv.env['API_KEY'];
    print(token);
    print(siret);
    final url = 'https://api.insee.fr/entreprises/sirene/V3/siret/$siret';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}'
    });

    if (response.statusCode == 200) {
      // Analyser la réponse JSON et vérifier la validité du SIRET
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse['header'];
    } else {
      // Gérer les erreurs de requête HTTP
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse['header'];
    }
  }

  // crea artisan
  static Future<int> createArtisan(
    String name,
    String lastname,
    String password,
    String email,
    String username,
    String telephone,
    String siret,
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
          'adress': adress,
          'domaine': domaine,
          'entreprise': entreprise,
          'note': "0",
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
    String picture,
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
          'picture': picture,
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

      return jsonResponse;
    } else {
      //print("getWorkByStatus échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getWorkDone(
      int state, int artisanID) async {
    var response = await http.get(
      Uri.parse("${url}getWorkDone"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'state': state.toString(),
        'artisanID': artisanID.toString(),
      },
    );

    if (response.statusCode == 200) {
      //print("getWorkByStatus réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

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

  static Future<bool> checkDevisExists(
      int artisanID, int particulierID, int workID) async {
    var response =
        await http.get(Uri.parse("${url}checkDevisExists"), headers: {
      "Content-Type": "application/json",
      "artisanid": artisanID.toString(),
      "particulierid": particulierID.toString(),
      "workid": workID.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['exists'];
    } else {
      throw Exception('Failed to check devis existence.');
    }
  }

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

  static Future<Map<String, dynamic>> getAllDevisFromArtisanAndParticulier(
      int artisanID, int particulierID) async {
    var response = await http.get(
      Uri.parse("${url}getAllDevisFromArtisanAndParticulier"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanID.toString(),
        'particulierID': particulierID.toString()
      },
    );

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

  static Future<Map<String, dynamic>> getAllDevisByStatus(
      int state, int artisanID) async {
    var response = await http.get(
      Uri.parse("${url}getDevisByStatus"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanid': artisanID.toString(),
        'state': state.toString(),
      },
    );

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
      int workID, int particulierID) async {
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
      final emailKey = dotenv.env['EMAIL_KEY'];
      final template =
          await rootBundle.loadString('assets/emails/closedChantier.html');

      final particulier =
          await ParticulierController.getParticulierById(particulierID);

      final work = await ChantierController.getChantierById(workID);

      try {
        final smtpServer = gmail("workr.professionel@gmail.com", emailKey!);
        String email = particulier["results"][0]['email'];
        String name = work["results"][0]['name'];
        final message = Message()
          ..from = Address("workr.professionel@gmail.com", 'L\'équipe Workr')
          ..recipients.add(email)
          ..subject = "Chantier cloturé : ${name}"
          ..html = template
              .replaceAll(
                  '[particulier]',
                  particulier["results"][0]['name'] +
                      ' ' +
                      particulier["results"][0]['lastname'])
              .replaceAll('[name]', work["results"][0]['name'])
              .replaceAll('[category]', work["results"][0]['category'])
              .replaceAll('[budget]', work["results"][0]['budget'])
              .replaceAll('[description]', work["results"][0]['description']);

        final sendReport = await send(message, smtpServer);
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }

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
      int particulierID) async {
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
        .then((http.Response response) async {
      //print("updateTask réussie Artisan Controller");

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (state == true) {
        final emailKey = dotenv.env['EMAIL_KEY'];
        final template =
            await rootBundle.loadString('assets/emails/endTask.html');

        final particulier =
            await ParticulierController.getParticulierById(particulierID);

        String email = particulier["results"][0]['email'];
        final smtpServer = gmail("workr.professionel@gmail.com", emailKey!);

        final message = Message()
          ..from = Address("workr.professionel@gmail.com", 'L\'équipe Workr')
          ..recipients.add(email)
          ..subject = "Tache terminé : ${name}"
          ..html = template
              .replaceAll(
                  '[particulier]',
                  particulier["results"][0]['name'] +
                      ' ' +
                      particulier["results"][0]['lastname'])
              .replaceAll('[name]', name)
              .replaceAll('[type]', type)
              .replaceAll('[start_at]', startAt)
              .replaceAll('[end_at]', endAt)
              .replaceAll('[description]', description);

        final sendReport = await send(message, smtpServer);
      }

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
      Uri.parse("${url}getAllConversationsFromArtisan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'artisanID': artisanID.toString()
      },
    );

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
