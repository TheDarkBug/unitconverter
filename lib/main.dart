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
  final String title = "Convert";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String selectedUnit = '';
  // List<String> units = ['Option 1', 'Option 2', 'Option 3'];
  double value = 0.0;
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /*DropdownButtonFormField(
              value: selectedOption,
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newOption) {
                setState(() {
                  selectedOption = newOption.toString();
                });
              },
            ),*/
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value',
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
                  this.value = value.isNotEmpty ? double.parse(value) : 0.0;
                });
              },
              // onSubmitted:
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: <Widget>[
                  Unit(
                    iSname: 'Kilometer',
                    mSname: 'Mile',
                    iSsymbol: 'km',
                    mSsymbol: 'mi',
                    value: value,
                    convert: (src) {
                      return src * 1.60934;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
