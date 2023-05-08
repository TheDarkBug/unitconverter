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
  NumStringLocales numString = NumStringLocales();
  void load(code) {
    main.load(code);
    settings.load(code);
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
