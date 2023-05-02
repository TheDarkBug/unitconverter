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
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double value = 0.0;
  bool isMetric = true;
  String title = 'Metric to Imperial';
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
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
                        title = isMetric
                            ? 'Metric to Imperial'
                            : 'Imperial to Metric';
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
      ),
    );
  }
}
