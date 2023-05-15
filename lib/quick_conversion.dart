import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'currencies.dart';
import 'locales.dart';
import 'unit.dart';

class QuickConversionPage extends StatefulWidget {
  const QuickConversionPage({super.key});
  @override
  State<QuickConversionPage> createState() => _QuickConversionPageState();
}

class _QuickConversionPageState extends State<QuickConversionPage> {
  double value = 0.0;
  bool isMetric = true;
  final TextEditingController controller = TextEditingController();
  late Section currenciesSection;
  List<Section> sections = [];
  List<UnitCard> lengthItems = [];
  List<UnitCard> tempItems = [];
  List<UnitCard> weightItems = [];
  List<UnitCard> volumeItems = [];
  List<bool> expanded = [true, true, true, true];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sections = [
      Section(
        title: currentLocale.quickConversion.length,
        children: [
          UnitCard(
              rightText: currentLocale.quickConversion.kilometer,
              leftText: currentLocale.quickConversion.mile,
              leftSymbol: 'km',
              rightSymbol: 'mi',
              leftValue: value,
              rightValue: isMetric ? value / 1.60934 : value * 1.60934,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.meter,
              leftText: currentLocale.quickConversion.yard,
              leftSymbol: 'm',
              rightSymbol: 'yd',
              leftValue: value,
              rightValue: isMetric ? value * 1.093613 : value / 1.093613,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.meter,
              leftText: currentLocale.quickConversion.feet,
              leftSymbol: 'm',
              rightSymbol: 'ft',
              leftValue: value,
              rightValue: isMetric ? value * 3.28084 : value / 3.28084,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.centimeter,
              leftText: currentLocale.quickConversion.inch,
              leftSymbol: 'cm',
              rightSymbol: 'in',
              leftValue: value,
              rightValue: isMetric ? value / 2.54 : value * 2.54,
              swapValues: isMetric),
        ],
      ),
      Section(
        title: currentLocale.quickConversion.temperature,
        children: [
          UnitCard(
              rightText: currentLocale.quickConversion.celsius,
              leftText: currentLocale.quickConversion.fahrenheit,
              leftSymbol: '°C',
              rightSymbol: '°F',
              leftValue: value,
              rightValue: isMetric ? (value * 1.8) + 32 : (value - 32) / 1.8,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.kelvin,
              leftText: currentLocale.quickConversion.fahrenheit,
              leftSymbol: 'K',
              rightSymbol: '°F',
              leftValue: value,
              rightValue: isMetric
                  ? ((value - 273.15) * 1.8) + 32
                  : ((value - 32) / 1.8) + 273.15,
              swapValues: isMetric),
        ],
      ),
      Section(
        title: currentLocale.quickConversion.weight,
        children: [
          UnitCard(
              rightText: currentLocale.quickConversion.kilogram,
              leftText: currentLocale.quickConversion.pound,
              leftSymbol: 'kg',
              rightSymbol: 'lb',
              leftValue: value,
              rightValue: isMetric ? value / 0.45359237 : value * 0.45359237,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.gram,
              leftText: currentLocale.quickConversion.ounce,
              leftSymbol: 'g',
              rightSymbol: 'oz',
              leftValue: value,
              rightValue: isMetric ? value / 2.834952 : value * 2.834952,
              swapValues: isMetric),
        ],
      ),
      Section(
        title: currentLocale.quickConversion.volume,
        children: [
          UnitCard(
              rightText: currentLocale.quickConversion.liter,
              leftText: currentLocale.quickConversion.gallon,
              leftSymbol: 'l',
              rightSymbol: 'gal',
              leftValue: value,
              rightValue: isMetric ? value / 3.78541 : value * 3.78541,
              swapValues: isMetric),
          UnitCard(
              rightText: currentLocale.quickConversion.liter,
              leftText: currentLocale.quickConversion.imperialGallon,
              leftSymbol: 'l',
              rightSymbol: 'gal',
              leftValue: value,
              rightValue: isMetric ? value / 4.54609 : value * 4.54609,
              swapValues: isMetric),
        ],
      ),
    ];
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
                        ? currentLocale.quickConversion.metric
                        : currentLocale.quickConversion.imperial,
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
          child: ListView(
            children: [
              for (int index = 0; index < sections.length; index++)
                ExpansionPanelList(
                  expansionCallback: (int panelIndex, bool isExpanded) {
                    setState(() {
                      expanded[index] = !isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Center(child: Text(sections[index].title)),
                        );
                      },
                      body: sections[index],
                      isExpanded: expanded[index],
                    )
                  ],
                ),
              CurrenciesPage(value: value),
            ],
          ),
        ),
      ],
    );
  }
}

class Section extends StatefulWidget {
  const Section({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Column(children: widget.children);
  }
}
