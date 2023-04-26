import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/view/LunchPage/firstpage.dart';
import 'package:my_app/view/Login/SelectionPage.dart';
import 'package:my_app/view/Register/registerselection.dart';

void main() {
  testWidgets('Test navigation from FirstPage', (WidgetTester tester) async {
    // Créez un MaterialApp pour pouvoir tester la navigation
    await tester.pumpWidget(MaterialApp(
      home: FirstPage(title: 'Test'),
      routes: {
        SelectionPage.tag: (context) => SelectionPage(),
        RegisterSelectionPage.tag: (context) => RegisterSelectionPage(),
      },
    ));

    // Vérifiez que les boutons "Connexion" et "Inscription" sont présents
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Inscription'), findsOneWidget);

    // Simulez un appui sur le bouton "Connexion" et vérifiez si la navigation se produit
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectionPage), findsOneWidget);

    // Revenez à la page précédente
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Simulez un appui sur le bouton "Inscription" et vérifiez si la navigation se produit
    await tester.tap(find.text('Inscription'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterSelectionPage), findsOneWidget);
  });
}
