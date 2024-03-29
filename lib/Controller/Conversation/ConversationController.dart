import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

class ConversationController {
  static var url = dotenv.env['DB_HOST'];

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

  static Future<Map<String, dynamic>> getOneConversation(
      int conversationid) async {
    var response =
        await http.get(Uri.parse("${url}getOneConversation"), headers: {
      "Content-Type": "application/json",
      "conversationid": conversationid.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load conversation.');
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

  static Future<Map<String, dynamic>> getAllMessageFromPublicConversation(
      int conversationID) async {
    var response = await http
        .get(Uri.parse("${url}getAllMessagesFromPublicConversation"), headers: {
      "Content-Type": "application/json",
      "conversationid": conversationID.toString()
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> sendMessagePublic(int conversationID,
      int senderID, String pseudo, String sender_type, String content) async {
    var response = await http.post(Uri.parse("${url}sendMessagePublic"), body: {
      "conversationID": conversationID.toString(),
      "senderID": senderID.toString(),
      "pseudo": pseudo,
      "sender_type": sender_type,
      "content": content,
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

  static Future<Map<String, dynamic>> sendMessage(int conversationID,
      int senderID, String pseudo, String sender_type, String content) async {
    var response = await http.post(Uri.parse("${url}sendMessage"), body: {
      "conversationID": conversationID.toString(),
      "senderID": senderID.toString(),
      "pseudo": pseudo,
      "sender_type": sender_type,
      "content": content,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getOneConversationFromWork(
      int workID) async {
    var response = await http.get(Uri.parse("${url}getOneConversationFromWork"),
        headers: {
          "Content-Type": "application/json",
          "workid": workID.toString()
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getAllMessageFromConversation(
      int conversationID) async {
    var response = await http
        .get(Uri.parse("${url}getAllMessagesFromConversation"), headers: {
      "Content-Type": "application/json",
      "conversationid": conversationID.toString()
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
