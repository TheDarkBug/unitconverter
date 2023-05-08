class MainLocales {
  String freedomUnits = '';
  String currencies = '';
  String numberToString = '';
  String settings = '';
  String about = '';
  String version = '';
  String loadingCurrencies = '';
  String timedOut = '';
  String notConnected = '';
  String retryLater = '';

  void load(String code) {
    switch (code) {
      case 'en':
        freedomUnits = 'Freedom Units';
        currencies = 'Currencies';
        numberToString = 'Number to String';
        settings = 'Settings';
        about = 'About';
        version = 'Version';
        loadingCurrencies = 'Loading Currencies from ';
        timedOut = 'Connection Timed Out';
        notConnected = 'Not connected';
        retryLater = 'Please Retry Later';
        break;
      case 'it':
        freedomUnits = 'Unità della libertà';
        currencies = 'Valute';
        numberToString = 'Numero a parola';
        settings = 'Impostazioni';
        about = 'Info';
        version = 'Versione';
        loadingCurrencies = 'Caricamento valute da ';
        timedOut = 'Connessione scaduta';
        notConnected = 'Connessione a internet assente';
        retryLater = 'Riprova più tardi';
        break;
      default:
        throw Exception('Locale code $code is not supported');
    }
  }
}

class SettingsLocales {
  String darkMode = '';
  String systemTheme = '';
  String language = '';

  void load(String code) {
    switch (code) {
      case 'en':
        darkMode = 'Dark Mode';
        systemTheme = 'System Theme';
        language = 'Language';
        break;
      case 'it':
        darkMode = 'Tema scuro';
        systemTheme = 'Tema di sistema';
        language = 'Lingua';
        break;
      default:
        throw Exception('Locale code $code is not supported');
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
      case 'en':
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
      default:
        throw Exception('Locale code $code is not supported');
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
      case 'en':
        break;
      case 'it':
        dollar = 'Dollari';
        canadianDollar = 'CA $dollar';
        australianDollar = 'AU $dollar';
        pound = 'Sterline';
        newZealandDollar = 'NZ $dollar';
        swissFranc = 'Franchi SW';
        break;
      default:
        throw Exception('Locale code $code is not supported');
    }
  }
}

class NumStringLocales {
  String langFilePath = '';
  String copied = '';

  void load(String code) {
    switch (code) {
      case 'en':
        langFilePath = 'assets/langs/english.txt';
        copied = 'Copied to Clipboard';
        break;
      case 'it':
        langFilePath = 'assets/langs/italian.txt';
        copied = 'Copiato negli appunti';
        break;
      default:
        throw Exception('Locale code $code is not supported');
    }
  }
}

class Locales {
  Locales(String code) {
    load(code);
  }
  List<Map> langs = [
    {'name': '', 'code': 'en'},
    {'name': '', 'code': 'it'}
  ];
  List id = ['', ''];
  String appName = 'Unit Converter';
  String appVersion = '1.0.0';
  MainLocales main = MainLocales();
  SettingsLocales settings = SettingsLocales();
  QuickConvertLocales quickConvert = QuickConvertLocales();
  CurrenciesLocales currencies = CurrenciesLocales();
  NumStringLocales numString = NumStringLocales();
  void load(code) {
    main.load(code);
    settings.load(code);
    quickConvert.load(code);
    currencies.load(code);
    numString.load(code);
    switch (code) {
      case 'en':
        langs[0]['name'] = 'English';
        langs[1]['name'] = 'Italian';
        id = ['en', 'English'];
        break;
      case 'it':
        langs[0]['name'] = 'Inglese';
        langs[1]['name'] = 'Italiano';
        id = ['it', 'Italiano'];
        break;
      default:
        throw Exception('Locale code $code is not supported');
    }
  }
}

Locales currentLocale = Locales('en');