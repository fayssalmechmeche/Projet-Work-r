import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/controller/artisan/artisancontroller.dart';

void main() {
  group('getWorkByStatus', () {
    //Test De la fonction getWorkByStatus
    test('Retourne un Map<String, dynamic> si le test reussi ', () async {
      final response = await ArtisanController.getWorkByStatus(0);
      expect(response, isA<Map<String, dynamic>>());
      expect(response.isNotEmpty, isTrue);
    });
    test('Retourne rien car la requete est fausse ', () async {
      final response = await ArtisanController.getWorkByStatus(4);
      expect(response, isA<Map<String, dynamic>>());
      expect(response.containsKey("results"), isTrue);
      expect(response["results"], isEmpty);
    });
  });

  //fin getWorkByStatus

  //Test de UpdateArtisan
  group('updateArtisan', () {
    test(
        'Retourne un Map<String, dynamic> si la requette recupere bien un message success : True',
        () async {
      final response = await ArtisanController.updateArtisan(
        1,
        'John',
        'Doe',
        'password123',
        'johndoe@example.com',
        'johndoe',
        '555-555-5555',
        '123 Main St',
        'ACME Inc.',
      );
      expect(response, isA<Map<String, dynamic>>());
      expect(response['success'], isTrue);
    });

    //fin de UpdateArtisan
  });


   test(
        'Retourne un Map<String, dynamic> si la requette recupere bien un message success : false',
        () async {
      final response = await ArtisanController.updateArtisan(
        0,
        'John',
        'Doe',
        'password123',
        'johndoe@example.com',
        'johndoe',
        '555-555-5555',
        '123 Main St',
        'ACME Inc.',
      );
      expect(response, isA<Map<String, dynamic>>());
      expect(response['resulst'], isNull);
    });

    //fin de UpdateArtisan
  }

