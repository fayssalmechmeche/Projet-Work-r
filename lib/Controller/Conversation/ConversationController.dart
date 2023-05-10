import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

class ConversationController {
  static var url = "http://localhost:3000/";

// checkConversationExists
  static Future<bool> checkConversationExists(
      int artisanID, int particulierID) async {
    var response =
        await http.get(Uri.parse("${url}checkConversationExists"), headers: {
      "Content-Type": "application/json",
      "artisanid": artisanID.toString(),
      "particulierid": particulierID.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['exists'];
    } else {
      throw Exception('Failed to check conversation existence.');
    }
  }

  static Future<Map<String, dynamic>> createConversation(
      int artisanID, int particulierID, String name) async {
    var response =
        await http.post(Uri.parse("${url}createConversation"), body: {
      "artisanID": artisanID.toString(),
      "particulierID": particulierID.toString(),
      "name": name,
    });

    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>>
      getAllConversationFromArtisanAndParticulier(
          int artisanID, int particulierid) async {
    var response = await http.get(
        Uri.parse("${url}getAllConversationFromArtisanAndParticulier"),
        headers: {
          "Content-Type": "application/json",
          "artisanid": artisanID.toString(),
          "particulierid": particulierid.toString(),
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  /////////////////////// CHANTIER CONVERSATION ///////////////////////
  ///
  static Future<Map<String, dynamic>> createChantierConversation(
      int workID, String artisanID, String particulierID) async {
    var response =
        await http.post(Uri.parse("${url}createChantierConversation"), body: {
      "workID": workID.toString(),
      "artisanID": artisanID.toString(),
      "particulierID": particulierID.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<bool> checkChantierConversationExists(int workID) async {
    var response = await http
        .get(Uri.parse("${url}checkChantierConversationExists"), headers: {
      "Content-Type": "application/json",
      "workid": workID.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['exists'];
    } else {
      throw Exception('Failed to check conversation existence.');
    }
  }
}
