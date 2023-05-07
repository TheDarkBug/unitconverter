import 'package:flutter/material.dart';

class Locales {
  static const LocalesDelegate delegate = LocalesDelegate();
  static const freedomUnits = 'Freedom Units';
  static const currencies = 'Currencies';
  static const numberToString = 'Number to String';
  static const settings = 'Settings';
  static const about = 'About';
}

class LocalesDelegate extends LocalizationsDelegate<Locales> {
  const LocalesDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<Locales> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return Locales();
      default:
        return Locales();
    }
  }

  @override
  bool shouldReload(LocalesDelegate old) => false;
}
