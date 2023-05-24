import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const NoInternetPage({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connexion perdue',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: onRefresh,
              child: Text('Rafraîchir'),
            ),
          ],
        ),
      ),
    );
  }
}
