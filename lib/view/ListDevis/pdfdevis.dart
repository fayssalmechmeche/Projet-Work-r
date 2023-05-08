import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PdfDevis extends StatefulWidget {
  const PdfDevis({Key? key}) : super(key: key);
  static const tag = "/PDFDevis";
  @override
  State<PdfDevis> createState() => _PdfDefisState();
}

class _PdfDefisState extends State<PdfDevis> {
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    // final artisan = ArtisanController.getArtisan(globalData.getId());

    return SafeArea(child: Text("l  "));
  }
}
