import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/view/login/LoginArt.dart';
import 'package:my_app/view/Navigation/NavigationPage.dart';
import 'package:provider/provider.dart';

import 'package:my_app/controller/global.dart';

void main() {
  testWidgets('test LoginArt button', (WidgetTester tester) async {
    // Configuration du Provider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalData()),
        ],
        child: MaterialApp(home: LoginArt()),
      ),
    );

    final Finder emailField = find.byType(TextFormField).first;
    final Finder passwordField = find.byType(TextFormField).last;
    final Finder button = find.byType(OutlinedButton);

    await tester.enterText(emailField, 'test@test.com');
    await tester.enterText(passwordField, '123456');
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byType(NavigationPage), findsOneWidget);
  });

  testWidgets('test LoginArt password visibility', (WidgetTester tester) async {
    // Configuration du Provider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalData()),
        ],
        child: MaterialApp(home: LoginArt()),
      ),
    );

    final Finder passwordField = find.byType(TextFormField).last;
    final Finder visibilityIcon = find.byIcon(Icons.visibility).last;

    await tester.tap(visibilityIcon);
    await tester.pump();

    expect(tester.widget<TextFormField>(passwordField), false);

    await tester.tap(visibilityIcon);
    await tester.pump();

    expect(tester.widget<TextFormField>(passwordField), true);
  });

  testWidgets('test LoginArt authentication failure', (WidgetTester tester) async {
    // Configuration du Provider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalData()),
        ],
        child: MaterialApp(home: LoginArt()),
      ),
    );

    final Finder emailField = find.byType(TextFormField).first;
    final Finder passwordField = find.byType(TextFormField).last;
    final Finder button = find.byType(OutlinedButton);

    await tester.enterText(emailField, 'test@test.com');
    await tester.enterText(passwordField, 'wrong_password');
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Email ou mot de passe incorrect'), findsOneWidget);
  });
}
