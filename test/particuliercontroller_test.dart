import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/controller/particulier/particuliercontroller.dart';

void main() {
  group('ParticulierController', () {
    test(
        'Retourne un Map<String, dynamic> si la requette recupere bien un message success : True',
        () async {
      // Arrange
      final token =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOjEsIm5hbWUiOiJqZWFucyIsImxhc3RuYW1lIjoicGFydGljdWxpZXIiLCJwYXNzd29yZCI6IiQyYiQxMCRQa0pyMmdKUzBZaGQ3RDN5ZjdRdWEuOUx5bDNoQk9uM05URGUwV3guc0ZEbXRKNEtia1FQeSIsImVtYWlsIjoicGFydGljdWxpZXJAcGFydGljdWxpZXIuY29tIiwidXNlcm5hbWUiOiJqZWFuIHBhdXZyZSIsInRlbGVwaG9uZSI6IjAxMDEwMTAxMDEiLCJjaXR5IjoicGFyaXMiLCJhZHJlc3MiOiJtb250cGFybmFzc2UiLCJwb3N0YWxDb2RlIjoiNzUwMDEiLCJwaWN0dXJlIjoiL1VzZXJzL21lcndhbi9MaWJyYXJ5L0RldmVsb3Blci9Db3JlU2ltdWxhdG9yL0RldmljZXMvNkNCRDE2OEItN0FCRS00OEEzLUI1OEMtMjUxOUU2QzZDRDQxL2RhdGEvQ29udGFpbmVycy9EYXRhL0FwcGxpY2F0aW9uLzY0QzcwNkFFLTI3ODYtNDRGQi1CNzQ3LUUwQzFGREJEM0IzQS9Eb2N1bWVudHMvbG9nby5wbmciLCJjaGFudGllciI6Im4iLCJmYXZvcml0ZSI6bnVsbH0.Xeq6tTHumtLhnQjBZMRMCQ2Zhw5r20jJN4q0_fBg0wI'; // A valid token for the API
      // Act
      final response = await ParticulierController.getInfo(token);
      // Assert
      expect(response, isA<Map<String, dynamic>>());
      expect(response['success'], isTrue);
    });
  });
}
