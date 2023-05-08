import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PdfDevis extends StatefulWidget {
  final File file;
  PdfDevis({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfDevis> createState() => _PdfDefisState();
}

class _PdfDefisState extends State<PdfDevis> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
