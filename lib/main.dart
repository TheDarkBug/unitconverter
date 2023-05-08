import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'locales.dart';
import 'quickconvert.dart';
import 'currencies.dart';
import 'numstring.dart';
import 'settings.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = Settings(
        themeSetter: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
        getTheme: () => themeMode,
        setLocale: (String code) {
          setState(() {
            currentLocale.load(code);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: currentLocale.appName,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeMode,
      home: HomeScreen(settings: settings),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.settings});
  final Settings settings;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedPage = const QuickConvertPage();
  String _selectedTitle = currentLocale.main.freedomUnits;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedTitle)),
      body: _selectedPage,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff0000b3), Colors.blue],
                ),
              ),
              child: Text(
                'Unit Converter',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(currentLocale.main.freedomUnits),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedTitle = currentLocale.main.freedomUnits;
                  _selectedPage = const QuickConvertPage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: Text(currentLocale.main.currencies),
              onTap: () async {
                Navigator.pop(context);

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            const CircularProgressIndicator(),
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                text: currentLocale.main.loadingCurrencies,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'JsDelivr',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            'https://cdn.jsdelivr.net'));
                                      },
                                  ),
                                  const TextSpan(text: '...'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });

                try {
                  await http.get(Uri.parse("https://cdn.jsdelivr.net")).timeout(
                    const Duration(seconds: 5),
                    onTimeout: () {
                      throw TimeoutException(currentLocale.main.timedOut);
                    },
                  );
                } catch (e) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(currentLocale.main.notConnected,
                            textAlign: TextAlign.center),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(currentLocale.main.retryLater),
                            const SizedBox(height: 20.0),
                            Text("$e"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                setState(() {
                  _selectedTitle = currentLocale.main.currencies;
                  _selectedPage = const CurrenciesPage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.numbers),
              title: Text(currentLocale.main.numberToString),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedTitle = currentLocale.main.numberToString;
                  _selectedPage = const NumStringPage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(currentLocale.main.settings),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedTitle = currentLocale.main.settings;
                  _selectedPage = SettingsPage(settings: widget.settings);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(currentLocale.main.about),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  showAboutDialog(
                    context: context,
                    applicationName: currentLocale.appName,
                    applicationVersion: currentLocale.appVersion,
                    applicationIcon: const Center(
                      child: Image(
                        image: AssetImage('assets/icons/icon.png'),
                        height: 85.0,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(currentLocale.main.aboutContent[0]),
                          GestureDetector(
                            child: const Text(
                              'TheDarkBug',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              launchUrl(
                                  Uri.parse('https://github.com/TheDarkBug'));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(currentLocale.main.aboutContent[1]),
                          GestureDetector(
                            child: const Text(
                              'Flutter',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              launchUrl(Uri.parse('https://flutter.dev'));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(currentLocale.main.aboutContent[2]),
                          GestureDetector(
                            child: const Text(
                              'JsDelivr',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              launchUrl(Uri.parse('https://cdn.jsdelivr.net'));
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
