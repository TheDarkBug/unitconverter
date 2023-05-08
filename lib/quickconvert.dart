import 'package:flutter/material.dart';
import 'locales.dart';
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
                    labelText: isMetric
                        ? currentLocale.quickConvert.metric
                        : currentLocale.quickConvert.imperial,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  currentLocale.quickConvert.length,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: currentLocale.quickConvert.kilometer,
                  leftText: currentLocale.quickConvert.mile,
                  leftSymbol: 'km',
                  rightSymbol: 'mi',
                  leftValue: value,
                  rightValue: isMetric ? value / 1.60934 : value * 1.60934,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.meter,
                  leftText: currentLocale.quickConvert.yard,
                  leftSymbol: 'm',
                  rightSymbol: 'yd',
                  leftValue: value,
                  rightValue: isMetric ? value * 1.093613 : value / 1.093613,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.meter,
                  leftText: currentLocale.quickConvert.feet,
                  leftSymbol: 'm',
                  rightSymbol: 'ft',
                  leftValue: value,
                  rightValue: isMetric ? value * 3.28084 : value / 3.28084,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.centimeter,
                  leftText: currentLocale.quickConvert.inch,
                  leftSymbol: 'cm',
                  rightSymbol: 'in',
                  leftValue: value,
                  rightValue: isMetric ? value / 2.54 : value * 2.54,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  currentLocale.quickConvert.temperature,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: currentLocale.quickConvert.celsius,
                  leftText: currentLocale.quickConvert.fahrenheit,
                  leftSymbol: '°C',
                  rightSymbol: '°F',
                  leftValue: value,
                  rightValue:
                      isMetric ? (value * 1.8) + 32 : (value - 32) / 1.8,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.kelvin,
                  leftText: currentLocale.quickConvert.fahrenheit,
                  leftSymbol: 'K',
                  rightSymbol: '°F',
                  leftValue: value,
                  rightValue: isMetric
                      ? ((value - 273.15) * 1.8) + 32
                      : ((value - 32) / 1.8) + 273.15,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  currentLocale.quickConvert.weight,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: currentLocale.quickConvert.kilogram,
                  leftText: currentLocale.quickConvert.pound,
                  leftSymbol: 'kg',
                  rightSymbol: 'lb',
                  leftValue: value,
                  rightValue:
                      isMetric ? value / 0.45359237 : value * 0.45359237,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.gram,
                  leftText: currentLocale.quickConvert.ounce,
                  leftSymbol: 'g',
                  rightSymbol: 'oz',
                  leftValue: value,
                  rightValue: isMetric ? value / 2.834952 : value * 2.834952,
                  swapValues: isMetric),
              const Divider(height: 40.0, indent: 20.0, endIndent: 20.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  currentLocale.quickConvert.volume,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              UnitCard(
                  rightText: currentLocale.quickConvert.liter,
                  leftText: currentLocale.quickConvert.gallon,
                  leftSymbol: 'l',
                  rightSymbol: 'gal',
                  leftValue: value,
                  rightValue: isMetric ? value / 3.78541 : value * 3.78541,
                  swapValues: isMetric),
              UnitCard(
                  rightText: currentLocale.quickConvert.liter,
                  leftText: currentLocale.quickConvert.imperialGallon,
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
