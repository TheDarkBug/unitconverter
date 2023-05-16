import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
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
  int fromCurrencyIdx = 0;
  final TextEditingController controller = TextEditingController();
  late Section currenciesSection;
  List<Section> sections = [];
  List<UnitCard> lengthItems = [];
  List<UnitCard> tempItems = [];
  List<UnitCard> weightItems = [];
  List<UnitCard> volumeItems = [];
  List<bool> expanded = [true, true, true, true, true];
  List<Map> currencies = [
    {
      'name': '${currentLocale.quickConversion.dollar} (USD)',
      'symbol': '\$',
      'code': 'usd',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.euro} (EUR)',
      'symbol': '€',
      'code': 'eur',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.canadianDollar} (CAD)',
      'symbol': 'CA\$',
      'code': 'cad',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.australianDollar} (AUD)',
      'symbol': 'AU\$',
      'code': 'aud',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.pound} (GBP)',
      'symbol': '£',
      'code': 'gbp',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.newZealandDollar} (NZD)',
      'symbol': 'NZ\$',
      'code': 'nzd',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.swissFranc} (CHF)',
      'symbol': 'CHF',
      'code': 'chf',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.yen} (JPY)',
      'symbol': '¥',
      'code': 'jpy',
      'value': -1.0
    },
    {
      'name': '${currentLocale.quickConversion.yuan} (CNY)',
      'symbol': '¥',
      'code': 'cny',
      'value': -1.0
    }
  ];

  Future<void> loadCurrencies() async {
    try {
      await http.get(Uri.parse("https://cdn.jsdelivr.net")).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(currentLocale.quickConversion.timedOut);
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(currentLocale.quickConversion.notConnected,
                textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(currentLocale.quickConversion.noCurrencies),
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

    for (int i = 0; i < currencies.length; i++) {
      final response = await http.get(Uri.parse(
          'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${currencies[0]['code']}/${currencies[i]['code']}.json'));
      if (response.statusCode == 200) {
        currencies[i]['value'] =
            json.decode(response.body)[currencies[i]['code']].toDouble();
      } else {
        throw Exception('Failed to load currency price');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies();
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
      Section(
        title: currentLocale.main.currencies,
        children: [
          for (int i = 0; i < currencies.length; i++)
            UnitCard(
              leftText: currencies[i]['name'],
              rightText: currencies[fromCurrencyIdx]['name'],
              leftSymbol: currencies[fromCurrencyIdx]['symbol'],
              rightSymbol: currencies[i]['symbol'],
              leftValue: value,
              rightValue: (value * currencies[fromCurrencyIdx]['value']) *
                  currencies[i]['value'],
              swapValues: true,
              places: 2,
            ),
        ],
      )
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
                  value: !isMetric,
                  onChanged: (value) {
                    setState(() {
                      isMetric = !value;
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
