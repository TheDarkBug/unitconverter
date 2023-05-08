import 'package:flutter/material.dart';
import 'unit.dart';

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
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      this.value = value.isNotEmpty ? double.parse(value) : 0.0;
                    });
                  },
                ),
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
            itemCount: 17,
            itemBuilder: (BuildContext context, int index) => Center(
                child: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Length',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: 'Kilometer',
                  leftText: 'Mile',
                  leftSymbol: 'km',
                  rightSymbol: 'mi',
                  leftValue: value,
                  rightValue: isMetric ? value / 1.60934 : value * 1.60934,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Meter',
                  leftText: 'Yard',
                  leftSymbol: 'm',
                  rightSymbol: 'yd',
                  leftValue: value,
                  rightValue: isMetric ? value * 1.093613 : value / 1.093613,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Meter',
                  leftText: 'Feet',
                  leftSymbol: 'm',
                  rightSymbol: 'ft',
                  leftValue: value,
                  rightValue: isMetric ? value * 3.28084 : value / 3.28084,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Centimeter',
                  leftText: 'Inch',
                  leftSymbol: 'cm',
                  rightSymbol: 'in',
                  leftValue: value,
                  rightValue: isMetric ? value / 2.54 : value * 2.54,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Temperature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: 'Celsius',
                  leftText: 'Fahrenheit',
                  leftSymbol: '°C',
                  rightSymbol: '°F',
                  leftValue: value,
                  rightValue:
                      isMetric ? (value * 1.8) + 32 : (value - 32) / 1.8,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Kelvin',
                  leftText: 'Fahrenheit',
                  leftSymbol: 'K',
                  rightSymbol: '°F',
                  leftValue: value,
                  rightValue: isMetric
                      ? ((value - 273.15) * 1.8) + 32
                      : ((value - 32) / 1.8) + 273.15,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Weight',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: 'Kilogram',
                  leftText: 'Pound',
                  leftSymbol: 'kg',
                  rightSymbol: 'lb',
                  leftValue: value,
                  rightValue:
                      isMetric ? value / 0.45359237 : value * 0.45359237,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Hectogram',
                  leftText: 'Ounce',
                  leftSymbol: 'g',
                  rightSymbol: 'oz',
                  leftValue: value,
                  rightValue: isMetric ? value / 2.834952 : value * 2.834952,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Volume',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: 'Liter',
                  leftText: 'US Gallon',
                  leftSymbol: 'l',
                  rightSymbol: 'gal',
                  leftValue: value,
                  rightValue: isMetric ? value / 3.78541 : value * 3.78541,
                  swapValues: isMetric),
              UnitCard(
                  rightText: 'Liter',
                  leftText: 'Imperial Gallon',
                  leftSymbol: 'l',
                  rightSymbol: 'gal',
                  leftValue: value,
                  rightValue: isMetric ? value / 4.54609 : value * 4.54609,
                  swapValues: isMetric),
            ][index]),
          ),
        ),
      ],
    );
  }
}
