import 'package:flutter/material.dart';
import 'unit.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedPage = const QuickConvertPage();
  String _selecctedTitle = "Metric ↔ Imperial";

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
                  _selecctedTitle = "Metric ↔ Imperial";
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
                  _selectedPage = const SettingsPage();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings'));
  }
}

class QuickConvertPage extends StatefulWidget {
  const QuickConvertPage({super.key});
  @override
  State<QuickConvertPage> createState() => _QuickConvertPageState();
}

class _QuickConvertPageState extends State<QuickConvertPage> {
  double value = 0.0;
  bool isMetric = true;
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: isMetric ? 'Metric' : 'Imperial',
                      hintText: 'e.g. 6.9',
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  controller.clear();
                                  value = 0.0;
                                });
                              })
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        this.value =
                            value.isNotEmpty ? double.parse(value) : 0.0;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Switch(
                  value: isMetric,
                  onChanged: (value) {
                    setState(() {
                      isMetric = value;
                    });
                  }),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: getUnits(value, isMetric).length,
            itemBuilder: (BuildContext context, int index) =>
                Center(child: getUnits(value, isMetric)[index]),
          ),
        ),
      ],
    );
  }
}
