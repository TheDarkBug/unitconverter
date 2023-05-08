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
    {'name': 'Dollar (USD)', 'symbol': '\$', 'code': 'usd', 'value': -1.0},
    {'name': 'Euro (EUR)', 'symbol': '€', 'code': 'eur', 'value': -1.0},
    {'name': 'CA Dollar (CAD)', 'symbol': 'CA\$', 'code': 'cad', 'value': -1.0},
    {'name': 'AU Dollar (AUD)', 'symbol': 'AU\$', 'code': 'aud', 'value': -1.0},
    {'name': 'Pound (GBP)', 'symbol': '£', 'code': 'gbp', 'value': -1.0},
    {'name': 'NZ Dollar (NZD)', 'symbol': 'NZ\$', 'code': 'nzd', 'value': -1.0},
    {'name': 'SW Franc (CHF)', 'symbol': 'CHF', 'code': 'chf', 'value': -1.0},
    {'name': 'Yen (JPY)', 'symbol': '¥', 'code': 'jpy', 'value': -1.0},
    {'name': 'CN Yuan (CNY)', 'symbol': '¥', 'code': 'cny', 'value': -1.0}
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
                    child: Text(currency['name']),
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
                  child: UnitCard(
                    leftText: currencies[fromCurrencyIdx]['name'],
                    rightText: currencies[index]['name'],
                    leftSymbol: currencies[fromCurrencyIdx]['symbol'],
                    rightSymbol: currencies[index]['symbol'],
                    value: value,
                    converted: (value * currencies[fromCurrencyIdx]['value']) /
                        currencies[index]['value'],
                    swapValues: true,
                    places: 2,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
