import 'package:flutter/material.dart';

class Unit extends StatefulWidget {
  const Unit(
      {super.key,
      required this.iSname,
      required this.mSname,
      required this.iSsymbol,
      required this.mSsymbol,
      required this.value,
      required this.convert});
  final String iSname;
  final String mSname;
  final String iSsymbol;
  final String mSsymbol;
  final double value;
  final double Function(double) convert;
  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      widget.iSname,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '${widget.value}${widget.iSsymbol}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Column(
                  children: <Widget>[
                    Text(
                      widget.mSname,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '${(widget.convert(widget.value) * 1000).roundToDouble() / 1000}${widget.mSsymbol}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
