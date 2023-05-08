import 'package:flutter/material.dart';

class UnitCard extends StatefulWidget {
  const UnitCard(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.rightSymbol,
      required this.leftSymbol,
      required this.leftValue,
      required this.rightValue,
      required this.swapValues,
      this.places = 3});
  final String leftText;
  final String rightText;
  final String rightSymbol;
  final String leftSymbol;
  final bool swapValues;
  final int places;
  final double leftValue;
  final double rightValue;
  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
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
                            widget.rightText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (widget.swapValues
                                    ? widget.leftValue
                                        .toStringAsFixed(widget.places)
                                    : widget.rightValue
                                        .toStringAsFixed(widget.places)) +
                                widget.leftSymbol,
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
                            widget.leftText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            (widget.swapValues
                                    ? widget.rightValue
                                        .toStringAsFixed(widget.places)
                                    : widget.leftValue
                                        .toStringAsFixed(widget.places)) +
                                widget.rightSymbol,
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
