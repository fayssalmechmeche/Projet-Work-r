import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

class ChantierController {
  static var url = dotenv.env['DB_HOST'];

  static Future<Map<String, dynamic>> getChantierById(int workId) async {
    print(workId.toString());
    var response = await http.get(
      Uri.parse("${url}getChantiersById"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'testes': workId.toString()
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
