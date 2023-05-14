import 'dart:ui';

class MainLocales {
  String quickConvertion = '';
  String advancedConvertion = '';
  String currencies = '';
  String numberToString = '';
  String settings = '';
  String about = '';
  String loadingCurrencies = '';
  String timedOut = '';
  String notConnected = '';
  String retryLater = '';
  String donate = '';
  AboutLocales aboutContent = AboutLocales();
  DonationLocales donationContent = DonationLocales();

  void load(String code) {
    aboutContent.load(code);
    donationContent.load(code);
    switch (code) {
      case 'it':
        quickConvertion = 'Conversione Rapida';
        advancedConvertion = 'Conversione Avanzata';
        currencies = 'Valute';
        numberToString = 'Numero a parola';
        settings = 'Impostazioni';
        about = 'Info';
        loadingCurrencies = 'Caricamento valute da ';
        timedOut = 'Connessione scaduta';
        notConnected = 'Connessione a internet assente';
        retryLater = 'Riprova più tardi';
        donate = 'Dona';
        break;
      case 'en':
      default:
        quickConvertion = 'Quick Convertion';
        advancedConvertion = 'Advanced Convertion';
        currencies = 'Currencies';
        numberToString = 'Number to String';
        settings = 'Settings';
        about = 'About';
        loadingCurrencies = 'Loading Currencies from ';
        timedOut = 'Connection Timed Out';
        notConnected = 'Not connected';
        retryLater = 'Please Retry Later';
        donate = 'Donate';
        break;
    }
  }
}

class AboutLocales {
  String createdBy = '';
  String poweredBy = '';
  String currenciesPoweredBy = '';
  String codeDistributedOn = '';
  String copyright = '© 2023';
  String privacyPolicy = '';

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
        createdBy = 'Created by ';
        poweredBy = 'Powered by ';
        currenciesPoweredBy = 'Currencies Powered by ';
        codeDistributedOn = 'Code Distributed on ';
        privacyPolicy = 'Privacy Policy';
        break;
    }
  }
}

class DonationLocales {
  String question = '';
  String description = '';
  String close = '';

  void load(String code) {
    switch (code) {
      case 'it':
        question = 'Mi offriresti un caffè?';
        description = '(Se ti è piaciuta l\'app ovviamente)';
        close = 'Chiudi';
        break;
      case 'en':
      default:
        question = 'If you like this app';
        description = 'Consider donating a coffee';
        close = 'Close';
        break;
    }
  }
}

class SettingsLocales {
  String darkMode = '';
  String systemTheme = '';
  String language = '';

  void load(String code) {
    switch (code) {
      case 'it':
        darkMode = 'Tema scuro';
        systemTheme = 'Tema di sistema';
        language = 'Lingua';
        break;
      case 'en':
      default:
        darkMode = 'Dark Mode';
        systemTheme = 'System Theme';
        language = 'Language';
        break;
    }
  }
}

class QuickConvertLocales {
  String metric = '';
  String imperial = '';
  String length = '';
  String kilometer = '';
  String mile = '';
  String meter = '';
  String yard = '';
  String feet = '';
  String centimeter = '';
  String inch = '';
  String temperature = '';
  String celsius = '';
  String fahrenheit = '';
  String kelvin = '';
  String weight = '';
  String kilogram = '';
  String pound = '';
  String gram = '';
  String ounce = '';
  String volume = '';
  String liter = '';
  String gallon = '';
  String imperialGallon = '';

  void load(String code) {
    switch (code) {
      case 'it':
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
        break;
      case 'en':
      default:
        metric = 'Metric';
        imperial = 'Imperial';
        length = 'Length';
        kilometer = 'Kilometer';
        mile = 'Mile';
        meter = 'Meter';
        yard = 'Yard';
        feet = 'Feet';
        centimeter = 'Centimeter';
        inch = 'Inch';
        temperature = 'Temperature';
        celsius = 'Celsius';
        fahrenheit = 'Fahrenheit';
        kelvin = 'Kelvin';
        weight = 'Weight';
        kilogram = 'Kilogram';
        pound = 'Pound';
        gram = 'Gram';
        ounce = 'Ounce';
        volume = 'Volume';
        liter = 'Liter';
        gallon = 'Gallon';
        imperialGallon = 'Imperial Gallon';
        break;
    }
  }
}

class CurrenciesLocales {
  String dollar = 'Dollar';
  String euro = 'Euro';
  String canadianDollar = 'CA Dollar';
  String australianDollar = 'AU Dollar';
  String pound = 'Pound';
  String newZealandDollar = 'NZ Dollar';
  String swissFranc = 'SW Franc';
  String yen = 'Yen';
  String yuan = 'CN Yuan';
  void load(String code) {
    switch (code) {
      case 'it':
        dollar = 'Dollari';
        canadianDollar = 'CA $dollar';
        australianDollar = 'AU $dollar';
        pound = 'Sterline';
        newZealandDollar = 'NZ $dollar';
        swissFranc = 'Franchi SW';
        break;
      case 'en':
      default:
        break;
    }
  }
}

class NumStringLocales {
  String langFilePath = '';
  String copied = '';

  void load(String code) {
    switch (code) {
      case 'it':
        langFilePath = 'assets/langs/italian.txt';
        copied = 'Copiato negli appunti';
        break;
      case 'en':
      default:
        langFilePath = 'assets/langs/english.txt';
        copied = 'Copied to Clipboard';
        break;
    }
  }
}

class Locales {
  Locales(String code) {
    load(code);
  }
  List<Map> langs = [
    {'name': '', 'code': 'en'},
    {'name': '', 'code': 'it'},
    {'name': '', 'code': 'sys'},
  ];
  List id = ['', ''];
  String appName = 'Unit Converter';
  String appVersion = '1.0.0';
  String developer = 'TheDarkBug';
  MainLocales main = MainLocales();
  SettingsLocales settings = SettingsLocales();
  QuickConvertLocales quickConvert = QuickConvertLocales();
  CurrenciesLocales currencies = CurrenciesLocales();
  NumStringLocales numString = NumStringLocales();
  void load(code) {
    bool isSystemLocale = false;
    if (code == 'sys') {
      code = window.locales[0].languageCode;
      isSystemLocale = true;
    }
    main.load(code);
    settings.load(code);
    quickConvert.load(code);
    currencies.load(code);
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
        langs[0]['name'] = 'English';
        langs[1]['name'] = 'Italian';
        langs[2]['name'] = 'System';
        id = ['en', 'English'];
        break;
    }
    if (isSystemLocale) {
      id = ['sys', 'Sistema'];
    }
  }
}

Locales currentLocale = Locales('sys');
