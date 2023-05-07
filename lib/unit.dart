import 'package:flutter/material.dart';

class Unit extends StatefulWidget {
  Unit(
      {super.key,
      required this.mSname,
      required this.iSname,
      required this.mSsymbol,
      required this.iSsymbol,
      required this.value,
      required this.converted,
      required this.isMetric,
      this.places = 3});
  final String mSname;
  final String iSname;
  final String mSsymbol;
  final String iSsymbol;
  final bool isMetric;
  final int places;
  double value;
  double converted;
  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.iSname,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${widget.isMetric || widget.converted <= 0 ? widget.value.toStringAsFixed(widget.places) : widget.converted.toStringAsFixed(widget.places)}${widget.iSsymbol}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.mSname,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.converted >= 0
                                ? '${widget.isMetric ? widget.converted.toStringAsFixed(widget.places) : widget.value.toStringAsFixed(widget.places)}${widget.mSsymbol}'
                                : 'Not available',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> getUnits(value, isMetric) {
  return <Widget>[
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
    Unit(
      iSname: 'Kilometer',
      mSname: 'Mile',
      iSsymbol: 'km',
      mSsymbol: 'mi',
      value: value,
      converted: isMetric ? value / 1.60934 : value * 1.60934,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Meter',
      mSname: 'Yard',
      iSsymbol: 'm',
      mSsymbol: 'yd',
      value: value,
      converted: isMetric ? value * 1.093613 : value / 1.093613,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Meter',
      mSname: 'Feet',
      iSsymbol: 'm',
      mSsymbol: 'ft',
      value: value,
      converted: isMetric ? value * 3.28084 : value / 3.28084,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Centimeter',
      mSname: 'Inch',
      iSsymbol: 'cm',
      mSsymbol: 'in',
      value: value,
      converted: isMetric ? value / 2.54 : value * 2.54,
      isMetric: isMetric,
    ),
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
    Unit(
      iSname: 'Celsius',
      mSname: 'Fahrenheit',
      iSsymbol: '°C',
      mSsymbol: '°F',
      value: value,
      converted: isMetric ? (value * 1.8) + 32 : (value - 32) / 1.8,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Kelvin',
      mSname: 'Fahrenheit',
      iSsymbol: 'K',
      mSsymbol: '°F',
      value: value,
      converted: isMetric
          ? ((value - 273.15) * 1.8) + 32
          : ((value - 32) / 1.8) + 273.15,
      isMetric: isMetric,
    ),
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
    Unit(
      iSname: 'Kilogram',
      mSname: 'Pound',
      iSsymbol: 'kg',
      mSsymbol: 'lb',
      value: value,
      converted: isMetric ? value / 0.45359237 : value * 0.45359237,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Hectogram',
      mSname: 'Ounce',
      iSsymbol: 'g',
      mSsymbol: 'oz',
      value: value,
      converted: isMetric ? value / 2.834952 : value * 2.834952,
      isMetric: isMetric,
    ),
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
    Unit(
      iSname: 'Liter',
      mSname: 'US Gallon',
      iSsymbol: 'l',
      mSsymbol: 'gal',
      value: value,
      converted: isMetric ? value / 3.78541 : value * 3.78541,
      isMetric: isMetric,
    ),
    Unit(
      iSname: 'Liter',
      mSname: 'Imperial Gallon',
      iSsymbol: 'l',
      mSsymbol: 'gal',
      value: value,
      converted: isMetric ? value / 4.54609 : value * 4.54609,
      isMetric: isMetric,
    ),
  ];
}
