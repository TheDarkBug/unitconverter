import 'package:flutter/material.dart';
import 'quickconvert.dart';
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
  HomeScreen({super.key, required this.settings});
  Settings settings;
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
                color: Colors.blue,
              ),
              child: Text('Universal Unit Converter'),
            ),
            ListTile(
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
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selecctedTitle = "Settings";
                  _selectedPage = SettingsPage(settings: widget.settings);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
