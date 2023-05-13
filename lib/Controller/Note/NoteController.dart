import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

class NoteController {
  static var url = "http://localhost:3000/";

  static Future<Map<String, dynamic>> addNotetoArtisan(
    int artisanID,
    int particulierID,
    int note,
  ) async {
    var response = await http.post(Uri.parse("${url}addNotetoArtisan"), body: {
      "artisanID": artisanID.toString(),
      "particulierID": particulierID.toString(),
      "note": note.toString(),
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

  static Future<Map<String, dynamic>> getNoteByArtisan(
    int artisanID,
    int particulierID,
  ) async {
    var response = await http.post(Uri.parse("${url}getNoteByArtisan"), body: {
      "artisanID": artisanID.toString(),
      "particulierID": particulierID.toString()
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

  static Future<Map<String, dynamic>> updateNoteOfArtisan(
      int artisanID, int note) async {
    var response = await http.post(Uri.parse("${url}updateNoteOfArtisan"),
        body: {"artisanID": artisanID.toString(), "note": note});

    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
