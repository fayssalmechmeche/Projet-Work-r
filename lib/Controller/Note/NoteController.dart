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

  static Future<bool> checkNoteExists(int artisanID, int particulierID) async {
    var response = await http.get(Uri.parse("${url}checkNoteExists"), headers: {
      "Content-Type": "application/json",
      "artisanid": artisanID.toString(),
      "particulierid": particulierID.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['exists'];
    } else {
      throw Exception('Failed to check note existence.');
    }
  }

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

    var notes = await getNoteByArtisan(artisanID);

    if (notes != null && notes["success"] == true && notes["results"] != null) {
      List<dynamic> noteList = notes["results"];
      var totalNote = 0; // Initialize with 0

      for (var i = 0; i < noteList.length; i++) {
        totalNote += noteList[i]["note"] as int;
      }

      var averageNote = totalNote ~/ noteList.length;

      await updateNoteOfArtisan(artisanID, averageNote);
    }

    if (response.statusCode == 200) {
      // Parse the JSON received in the response
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getNoteByArtisan(
    int artisanID,
  ) async {
    var response =
        await http.get(Uri.parse("${url}getNoteByArtisan"), headers: {
      "artisanid": artisanID.toString(),
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
        body: {"artisanID": artisanID.toString(), "note": note.toString()});

    if (response.statusCode == 200) {
      // Parser le JSON reçu en réponse

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getOneNoteByArtisan(
    int artisanID,
    int particulierID,
  ) async {
    var response =
        await http.get(Uri.parse("${url}getOneNoteByArtisan"), headers: {
      "artisanid": artisanID.toString(),
      "particulierid": particulierID.toString(),
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
}
