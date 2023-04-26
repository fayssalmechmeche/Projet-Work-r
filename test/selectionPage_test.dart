import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/view/login/SelectionPage.dart';
import 'package:my_app/view/Login/login.dart';
import 'package:my_app/view/Login/loginart.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controller/global.dart';

void main() {
  testWidgets('SelectionPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalData()),
      ],
      child: MaterialApp(
        initialRoute: SelectionPage.tag,
        routes: {
          SelectionPage.tag: (context) => SelectionPage(),
          LoginArt.tag: (context) => LoginArt(),
          Login.tag: (context) => Login(),
        },
      ),
    ));

    // verifie que le logo est affiché
    expect(find.byType(Image), findsOneWidget);

    // verifie que le texte "Je me connecte en tant que :" est affiché
    expect(find.text("Je me connecte en tant que :"), findsOneWidget);

    // verifie que le bouton "Particulier" est affiché
    expect(find.text("Particulier"), findsOneWidget);
   

    // verifie que le bouton "Artisan" est affiché
    expect(find.text("Artisan"), findsOneWidget);
    
  });
}
