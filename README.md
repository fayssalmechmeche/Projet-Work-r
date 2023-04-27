# Work'r

![My Image](assets/logo.png)

## Description

Work'r est notre projet de fin d'année. C'est une application developpé en Flutter par un groupe de trois etudiants

- [Merwan](https://github.com/Meerwaan)
- [Fayssal](https://github.com/fayssalmechmeche)
- [Yannis](https://github.com/yayaro27)

Le but de Work'r est de simplifier la mise en relation entre les personnes qui veulent effectuer des travaux chez eux et les artisans adapté a leurs besoins.

### Pourquoi Flutter ?

Nous avons choisi Flutter afin que notre application soit dsponible à la fois sur IOS et Android

### Lancement de l'application

npm i
npm start
flutter run

### Identifiant LocalHost

Artisan :

mail : artisan@artisan.com
mdp : artisan

Particulier :

mail : particulier@particulier.com
mdp : particulier

Database :
host: "localhost",
user: "root",
password: "",
database: "workrdb",


#### Comment lancer les test 

Pour lancer les tests de artisanController il faut lancer la commande suivante : 

```bash
flutter test test/artisanController_test.dart
```

Pour lancer les tests de particulierController il faut lancer la commande suivante : 

```bash
flutter test test/particulierController_test.dart
```

Pour lancer les test de l'affichage de la page SelectionPage 

```bash
flutter test test/selectionPage_test.dart
```

Pour lancer les test de l'affichage de la page loginart

```bash 
flutter test test/loginart_test.dart
```
