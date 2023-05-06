import 'package:flutter/foundation.dart';

class GlobalData with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  Map<String, dynamic> user = {};
  Map<String, dynamic> chantier = {};

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void setUser(Map<String, dynamic> user, int role) {
    this.user = user;
    this.user['role'] = role;
    notifyListeners();
  }

  String getEmail() {
    return user["email"];
  }

  int getId() {
    return user["_id"];
  }

  String getPassword() {
    if (user["password"] == null)
      return "inconnu";
    else
      return user["password"];
  }

  String getUsername() {
    if (user["username"] == null)
      return "inconnu";
    else
      return user["username"];
  }

  int getRole() {
    return user['role'];
  }

  String getName() {
    if (user["name"] == null)
      return "inconnu";
    else
      return user["name"];
  }

  String getLastName() {
    if (user["lastname"] == null)
      return "inconnu";
    else
      return user["lastname"];
  }

  String getPhone() {
    if (user["telephone"] == null)
      return "inconnu";
    else
      return user["telephone"];
  }

  String getAdress() {
    if (user["adress"] == null)
      return "inconnu";
    else
      return user["adress"];
  }

  String getCity() {
    if (user["city"] == null)
      return "inconnu";
    else
      return user["city"];
  }

  String getPostalCode() {
    if (user["postalCode"] == null)
      return "inconnu";
    else
      return user["postalCode"];
  }

  String getEntreprise() {
    if (user["entreprise"] == null)
      return "inconnu";
    else
      return user["entreprise"];
  }

  String getSiret() {
    if (user["siret"] == null)
      return "inconnu";
    else
      return user["siret"];
  }

  String getDomaine() {
    if (user["domaine"] == null)
      return "inconnu";
    else
      return user["domaine"];
  }

  String getPicture() {
    if (user["picture"] == null)
      return "https://www.woolha.com/media/2020/03/eevee.png";
    else
      return user["picture"];
  }

  String getMobilite() {
    if (user["mobilite"] == null)
      return "inconnu";
    else
      return user["mobilite"];
  }

  //////////////////////////////// chantier ////////////////////////////////

  void setChantier(Map<String, dynamic> chantier) {
    this.chantier = chantier;
    notifyListeners();
  }

  Map<String, dynamic> getChantier() {
    return chantier;
  }

  int getIdChantier() {
    return chantier["id"];
  }
}
