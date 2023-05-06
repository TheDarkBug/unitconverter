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
  bool isMetric = true;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrency('EUR').then((value) {
      print(round(value, 2));
    });
  }

  Future<double> getCurrency(String name) async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=${name}USDT'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final price = jsonBody['price'];
      return double.parse(price);
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Center(
              child: Unit(
                iSname: 'Dollar',
                mSname: 'Euro',
                iSsymbol: '\$',
                mSsymbol: '€',
                value: value,
                converted: isMetric ? value / 4.54609 : value * 4.54609,
                isMetric: isMetric,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
