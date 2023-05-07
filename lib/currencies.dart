import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'unit.dart';

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});
  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  double value = 0.0;
  List<Map> currencies = [
    {
      'name': 'Dollar',
      'short': 'Dollar',
      'symbol': '\$',
      'code': 'usd',
      'value': -1.0
    },
    {
      'name': 'Euro',
      'short': 'Euro',
      'symbol': '€',
      'code': 'eur',
      'value': -1.0
    },
    {
      'name': 'Canadian Dollar',
      'short': 'CA Dollar',
      'symbol': 'CA\$',
      'code': 'cad',
      'value': -1.0
    },
    {
      'name': 'Australian Dollar',
      'short': 'AU Dollar',
      'symbol': 'AU\$',
      'code': 'aud',
      'value': -1.0
    },
    {
      'name': 'Pound',
      'short': 'Pound',
      'symbol': '£',
      'code': 'gbp',
      'value': -1.0
    },
    {
      'name': 'New Zealand Dollar',
      'short': 'NZ Dollar',
      'symbol': 'NZ\$',
      'code': 'nzd',
      'value': -1.0
    },
    {
      'name': 'Swiss Franc',
      'short': 'SW Franc',
      'symbol': 'CHF',
      'code': 'chf',
      'value': -1.0
    },
  ];
  int fromCurrencyIdx = 0;
  final TextEditingController controller = TextEditingController();

  Future<void> loadCurrencies() async {
    for (int i = 0; i < currencies.length; i++) {
      getCurrencyConversion(currencies[0]['code'], currencies[i]['code'])
          .then((value) {
        setState(() {
          currencies[i]['value'] = value;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies().then((value) {
      Navigator.pop(context);
    });
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
                    labelText: currencies[fromCurrencyIdx]['name'],
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
              child: DropdownButton<String>(
                value: currencies[fromCurrencyIdx]['code'],
                elevation: currencies.length,
                onChanged: (String? value) {
                  setState(() {
                    fromCurrencyIdx =
                        currencies.indexWhere((e) => e['code'] == value);
                  });
                },
                items: currencies.map((currency) {
                  return DropdownMenuItem<String>(
                    value: currency['code'],
                    child: Text(currency['short']),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Unit(
                    iSname: currencies[fromCurrencyIdx]['name'],
                    mSname: currencies[index]['name'],
                    iSsymbol: currencies[fromCurrencyIdx]['symbol'],
                    mSsymbol: currencies[index]['symbol'],
                    value: value,
                    converted: (value * currencies[fromCurrencyIdx]['value']) /
                        currencies[index]['value'],
                    isMetric: true,
                    places: 2,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
