import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'locales.dart';
import 'quick_conversion.dart';
import 'advanced_conversion.dart';
import 'num_string.dart';
import 'settings.dart';
import 'about.dart';
import 'donation.dart';

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
    rootBundle.loadString('LICENSE').then((value) {
      LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
          LicenseEntryWithLineBreaks(<String>['Unit Converter'], value)));
    });
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
  Widget _selectedPage = const QuickConversionPage();
  String _selectedTitle = currentLocale.main.quickConversionion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedTitle)),
      body: _selectedPage,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff0000b3), Colors.blue],
                ),
              ),
              child: Text(
                currentLocale.appName,
                style: const TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(currentLocale.main.quickConversionion),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedTitle = currentLocale.main.quickConversionion;
                  _selectedPage = const QuickConversionPage();
                });
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.flip_camera_android),
            //   title: Text(currentLocale.main.advancedConvertion),
            //   onTap: () {
            //     Navigator.pop(context);
            //     setState(() {
            //       _selectedTitle = currentLocale.main.advancedConvertion;
            //       _selectedPage = const AdvancedConversionPage();
            //     });
            //   },
            // ),
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
                  AppAboutDialog(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(currentLocale.main.donate),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => const DonationDialog(),
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
