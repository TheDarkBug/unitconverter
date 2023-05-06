import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'quickconvert.dart';
import 'currencies.dart';
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
  void setTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  ThemeMode getTheme() {
    return themeMode;
  }

  @override
  void initState() {
    super.initState();
    settings = Settings(themeSetter: setTheme, getTheme: getTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
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
  String _selecctedTitle = "Metric <-> Imperial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selecctedTitle)),
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
              title: const Text('Freedom Units'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selecctedTitle = "Metric <-> Imperial";
                  _selectedPage = const QuickConvertPage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Currencies'),
              onTap: () async {
                Navigator.pop(context);

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            SizedBox(height: 20),
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading currencies from binance...'),
                          ],
                        ),
                      );
                    });

                try {
                  await http.get(Uri.parse("https://api.binance.com")).timeout(
                    const Duration(seconds: 5),
                    onTimeout: () {
                      return http.Response("Connection timed out!", 408);
                    },
                  ).then((value) {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No Internet Connection'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Please check your internet connection'),
                            const SizedBox(height: 20.0),
                            Text("$e"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                setState(() {
                  _selecctedTitle = "Money";
                  _selectedPage = const CurrenciesPage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selecctedTitle = "Settings";
                  _selectedPage = SettingsPage(settings: widget.settings);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Unit Converter',
                      applicationVersion: '1.0.0',
                      applicationIcon: const FlutterLogo(),
                      children: <Widget>[
                        const Text('Unit Converter'),
                        const Text('Version 1.0.0'),
                      ]);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
