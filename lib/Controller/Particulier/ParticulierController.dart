import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

class ParticulierController {
  static var url = "http://localhost:3000/";

  // create particulier
  static Future<int> createParticulier(
    String name,
    String lastname,
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
          'lastname': lastname,
          'password': password,
          'email': email,
          'username': username,
          'telephone': telephone,
          'city': city,
          'adress': adress,
          'postalCode': postalCode,
          'picture': 'null',
          'chantier': 'null',
        }));

    //print('Response status 200: ${response.statusCode}');
    //print('Response body: ${response.body}');
    return response.statusCode;
  }

  // authenticate particulier
  static Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    var response = await http.post(Uri.parse("${url}authenticateParticulier"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    // Vérifier que la réponse a un statut OK
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      //print("connexion réussie Particulier Controller");
      //print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("connexion échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // get info by token particulier
  static Future<Map<String, dynamic>> getInfo(String token) async {
    var response = await http
        .get(Uri.parse("${url}getinfoParticulier"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}'
    });
    if (response.statusCode == 200) {
      //print("getInfo réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getInfo échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // update particulier
  static Future<Map<String, dynamic>> updateParticulier(
    int id,
    String name,
    String lastname,
    String? password,
    String email,
    String username,
    String telephone,
    String city,
    String adress,
    String postalCode,
    String picture,
  ) async {
    var response = await http.post(Uri.parse("${url}updateParticulier"),
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
          'city': city,
          'adress': adress,
          'postalCode': postalCode,
          'picture': picture,
          'chantier': 'null',
        }));
    //print('Response status 200: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      //print("connexion réussie Particulier Controller");
      //print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("connexion échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getParticulierById(int id) async {
    var response = await http
        .get(Uri.parse("${url}getParticulierById"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'id': id.toString(),
    });

    //print('Response status 200: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      //print("connexion réussie Particulier Controller");
      //print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("connexion échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // create chantier
  static Future<Map<String, dynamic>> createChantier(
    String name,
    String type,
    String category,
    String budget,
    String description,
    int particulierID,
  ) async {
    var response = await http.post(Uri.parse("${url}addChantier"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'type': type,
          'category': category,
          'budget': budget,
          'state': 0,
          'description': description,
          'particulierID': particulierID.toString(),
        }));

    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse
      //print("creation de chantier réussie Particulier Controller");
      //print(response.body);

      var artisans = await ArtisanController.getAllArtisan();

      for (var artisan in artisans['results']) {
        String email = artisan['email'];
        //print(email);

        // Envoie un email à cet email
        final smtpServer =
            gmail("workr.professionel@gmail.com", "khimpyseszmipezx");

        final message = Message()
          ..from = Address("workr.professionel@gmail.com", 'L\'équipe Workr')
          ..recipients.add(email)
          ..subject = 'Nouveau chantier : ${category}}'
          ..text = 'Un nouveau chantier a été créé par un particulier. \n\n';

        try {
          final sendReport = await send(message, smtpServer);
        } on MailerException catch (e) {
          //print('Message not sent.');
          for (var p in e.problems) {
            //print('Problem: ${p.code}: ${p.msg}');
          }
        }
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Use the SmtpServer class to configure an SMTP server:
      // final smtpServer = SmtpServer('smtp.domain.com');
      // See the named arguments of SmtpServer for further configuration
      // options.

      // Create our message.

      return jsonResponse;
    } else {
      //print("creation de chantier échoué Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // get chantier by id particulier
  static Future<Map<String, dynamic>> getChantierById(int particulierId) async {
    //print(particulierId.toString());
    var response = await http.get(
      Uri.parse("${url}getAllChantiersByParticulier"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'particulierID': particulierId.toString()
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

  // add favorite artisan to particulier
  static Future<Map<String, dynamic>> addFavoriteArtisanToParticulier(
      int ParticulierId, int ArtisanId) async {
    var response =
        await http.post(Uri.parse("${url}addFavoriteArtisanToParticulier"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'particulierID': ParticulierId.toString(),
              'artisanID': ArtisanId.toString(),
            }));

    if (response.statusCode == 200) {
      //print("addFavoriteArtisanToParticulier réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("addFavoriteArtisanToParticulier échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  // get favorite artisan by particulier
  static Future<Map<String, dynamic>> getFavoriteArtisanOfParticulier(
      int particulierid) async {
    print(particulierid.toString());
    var response = await http.get(
      Uri.parse("${url}getFavoriteArtisanOfParticulier"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'particulierID': particulierid.toString()
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      //print("getFavoriteArtisanOfParticulier réussie Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      //print("getFavoriteArtisanOfParticulier échouée Particulier Controller");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getAllDevis(int particulierID) async {
    var response = await http.get(
      Uri.parse("${url}getAllDevisParticulier"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'particulierID': particulierID.toString()
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

  static Future<Map<String, dynamic>> getActifDevisByWork(int workID) async {
    var response = await http.get(
      Uri.parse("${url}getActifDevisByWork"),
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

  static Future<Map<String, dynamic>> refuseDevis(
      int particulierID, int devisID) async {
    var response = await http.post(Uri.parse("${url}refuseDevis"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'devisID': devisID.toString(),
          'particulierID': particulierID.toString(),
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

  static Future<Map<String, dynamic>> accepteDevis(
      int particulierID, int devisID, int workID, int artisanID) async {
    var response = await http.post(Uri.parse("${url}accepteDevis"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'devisID': devisID.toString(),
          'particulierID': particulierID.toString(),
          'workID': workID.toString(),
          'artisanID': artisanID.toString(),
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
}
