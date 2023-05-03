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
  void dispose() {
    controller.dispose();
    super.dispose();
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
    );
  }
}
