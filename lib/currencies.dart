import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'locales.dart';
import 'unit.dart';

class CurrenciesPage extends StatefulWidget {
  CurrenciesPage({super.key, required this.value});
  double value;

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  bool isExpanded = true;
  DateTime timestamp = DateTime.now();
  List<Map> currencies = [
    {
      'name': '${currentLocale.currencies.dollar} (USD)',
      'symbol': '\$',
      'code': 'usd',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.euro} (EUR)',
      'symbol': '€',
      'code': 'eur',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.canadianDollar} (CAD)',
      'symbol': 'CA\$',
      'code': 'cad',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.australianDollar} (AUD)',
      'symbol': 'AU\$',
      'code': 'aud',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.pound} (GBP)',
      'symbol': '£',
      'code': 'gbp',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.newZealandDollar} (NZD)',
      'symbol': 'NZ\$',
      'code': 'nzd',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.swissFranc} (CHF)',
      'symbol': 'CHF',
      'code': 'chf',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.yen} (JPY)',
      'symbol': '¥',
      'code': 'jpy',
      'value': -1.0
    },
    {
      'name': '${currentLocale.currencies.yuan} (CNY)',
      'symbol': '¥',
      'code': 'cny',
      'value': -1.0
    }
  ];
  int fromCurrencyIdx = 0;
  final TextEditingController controller = TextEditingController();

  Future<void> loadCurrencies() async {
    try {
      await http.get(Uri.parse("https://cdn.jsdelivr.net")).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(currentLocale.main.timedOut);
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(currentLocale.main.notConnected,
                textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(currentLocale.main.retryLater),
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
      final value = await getCurrencyConversion(
          currencies[0]['code'], currencies[i]['code']);
      setState(() {
        currencies[i]['value'] = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies();
  }

  Future<double> getCurrencyConversion(String from, String to) async {
    final response = await http.get(Uri.parse(
        'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$from/$to.json'));
    if (response.statusCode == 200) {
      return json.decode(response.body)[to].toDouble();
    } else {
      throw Exception('Failed to load currency price');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() {
          this.isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Center(child: Text(currentLocale.main.currencies)),
            );
          },
          body: Column(children: [
            for (int i = 0; i < currencies.length; i++)
              UnitCard(
                leftText: currencies[i]['name'],
                rightText: currencies[fromCurrencyIdx]['name'],
                leftSymbol: currencies[fromCurrencyIdx]['symbol'],
                rightSymbol: currencies[i]['symbol'],
                leftValue: widget.value,
                rightValue:
                    (widget.value * currencies[fromCurrencyIdx]['value']) *
                        currencies[i]['value'],
                swapValues: true,
                places: 2,
              ),
          ]),
          isExpanded: isExpanded,
        )
      ],
    );
  }
}
