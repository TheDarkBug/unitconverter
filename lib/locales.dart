import 'dart:ui';

class MainLocales {
  String quickConversionion = 'Quick Convertion';
  String advancedConvertion = 'Advanced Convertion';
  String currencies = 'Currencies';
  String numberToString = 'Number to String';
  String settings = 'Settings';
  String about = 'About';
  String donate = 'Donate';
  AboutLocales aboutContent = AboutLocales();
  DonationLocales donationContent = DonationLocales();

  void load(String code) {
    aboutContent.load(code);
    donationContent.load(code);
    switch (code) {
      case 'it':
        quickConversionion = 'Conversione Rapida';
        advancedConvertion = 'Conversione Avanzata';
        currencies = 'Valute';
        numberToString = 'Numero a parola';
        settings = 'Impostazioni';
        about = 'Info';
        donate = 'Dona';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class AboutLocales {
  String createdBy = 'Created by ';
  String poweredBy = 'Powered by ';
  String currenciesPoweredBy = 'Currencies Powered by ';
  String codeDistributedOn = 'Code Distributed on ';
  String copyright = '© 2023';
  String privacyPolicy = 'Privacy Policy';

  void load(String code) {
    switch (code) {
      case 'it':
        createdBy = 'Creato da ';
        poweredBy = 'Sviluppato tramite ';
        currenciesPoweredBy = 'Valute Ottenute da ';
        codeDistributedOn = 'Codice Distribuito su ';
        privacyPolicy = 'Politica della privacy';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class DonationLocales {
  String question = 'If you like this app';
  String description = 'Consider donating a coffee';
  String close = 'Close';

  void load(String code) {
    switch (code) {
      case 'it':
        question = 'Mi offriresti un caffè?';
        description = '(Se ti è piaciuta l\'app ovviamente)';
        close = 'Chiudi';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class SettingsLocales {
  String darkMode = 'Dark Mode';
  String systemTheme = 'System Theme';
  String language = 'Language';

  void load(String code) {
    switch (code) {
      case 'it':
        darkMode = 'Tema scuro';
        systemTheme = 'Tema di sistema';
        language = 'Lingua';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class QuickConvertLocales {
  // measure units
  String metric = 'Metric';
  String imperial = 'Imperial';
  String length = 'Length';
  String kilometer = 'Kilometer';
  String mile = 'Mile';
  String meter = 'Meter';
  String yard = 'Yard';
  String feet = 'Feet';
  String centimeter = 'Centimeter';
  String inch = 'Inch';
  String temperature = 'Temperature';
  String celsius = 'Celsius';
  String fahrenheit = 'Fahrenheit';
  String kelvin = 'Kelvin';
  String weight = 'Weight';
  String kilogram = 'Kilogram';
  String pound = 'Pound';
  String gram = 'Gram';
  String ounce = 'Ounce';
  String volume = 'Volume';
  String liter = 'Liter';
  String gallon = 'Gallon';
  String imperialGallon = 'Imperial Gallon';
  // connection
  String timedOut = 'Connection timed out';
  String notConnected = 'No internet connection';
  String noCurrencies = 'Currencies conversion will not be available';
  // currencies
  String dollar = 'Dollar';
  String euro = 'Euro';
  String canadianDollar = 'CA Dollar';
  String australianDollar = 'AU Dollar';
  String gbPound = 'Pound';
  String newZealandDollar = 'NZ Dollar';
  String swissFranc = 'SW Franc';
  String yen = 'Yen';
  String yuan = 'CN Yuan';

  String chooseFromCurrency = 'Choose Currency to convert';

  void load(String code) {
    switch (code) {
      case 'it':
        // measure units
        metric = 'Sistema Metrico';
        imperial = 'Sistema Imperiale';
        length = 'Lunghezza';
        kilometer = 'Kilometri';
        mile = 'Miglia';
        meter = 'Metri';
        yard = 'Iarde';
        feet = 'Piedi';
        centimeter = 'Centimetri';
        inch = 'Pollici';
        temperature = 'Temperatura';
        celsius = 'Celsius';
        fahrenheit = 'Fahrenheit';
        kelvin = 'Kelvin';
        weight = 'Peso';
        kilogram = 'Kilogrammi';
        pound = 'Libbre';
        gram = 'Grammi';
        ounce = 'Once';
        volume = 'Volume';
        liter = 'Litri';
        gallon = 'Galloni';
        imperialGallon = 'Galloni Imperiali';
        // connection
        timedOut = 'Connessione scaduta';
        notConnected = 'Connessione a internet assente';
        noCurrencies = 'La conversione delle valute non sarà disponibile';
        // currencies
        dollar = 'Dollari';
        canadianDollar = 'CA $dollar';
        australianDollar = 'AU $dollar';
        gbPound = 'Sterline';
        newZealandDollar = 'NZ $dollar';
        swissFranc = 'Franchi SW';

        chooseFromCurrency = 'Scegli la valuta da convertire';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class NumStringLocales {
  String langFilePath = 'assets/langs/english.txt';
  String copied = 'Copied to Clipboard';

  void load(String code) {
    switch (code) {
      case 'it':
        langFilePath = 'assets/langs/italian.txt';
        copied = 'Copiato negli appunti';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class Locales {
  Locales(String code) {
    load(code);
  }
  List<Map> langs = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Italian', 'code': 'it'},
    {'name': 'System', 'code': 'sys'},
  ];
  List id = ['', ''];
  String appName = 'Unit Converter';
  String appVersion = '1.0.1';
  String developer = 'TheDarkBug';
  MainLocales main = MainLocales();
  SettingsLocales settings = SettingsLocales();
  QuickConvertLocales quickConversion = QuickConvertLocales();
  NumStringLocales numString = NumStringLocales();
  void load(code) {
    bool isSystemLocale = false;
    if (code == 'sys') {
      code = window.locales[0].languageCode;
      isSystemLocale = true;
    }
    main.load(code);
    settings.load(code);
    quickConversion.load(code);
    numString.load(code);
    switch (code) {
      case 'it':
        langs[0]['name'] = 'Inglese';
        langs[1]['name'] = 'Italiano';
        langs[2]['name'] = 'Sistema';
        id = ['it', 'Italiano'];
        break;
      case 'en':
      default:
        id = ['en', 'English'];
        break;
    }
    if (isSystemLocale) {
      id = ['sys', 'Sistema'];
    }
  }
}

Locales currentLocale = Locales('sys');
