import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxButton extends StatefulWidget {
  final String? text1;
  final VoidCallback? callback;
  bool? select;

  CheckBoxButton(
      {Key? key, this.text1, this.callback, this.select})
      : super(key: key);

  @override
  State<CheckBoxButton> createState() => _CheckBoxButtonState();
}

class _CheckBoxButtonState extends State<CheckBoxButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.redAccent,
          value: widget.select,
          onChanged: (value) {
            setState(() {
              widget.select = value!;
              widget.callback!();
            });
          },
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 10,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: ' ${widget.text1}',
                  style: const TextStyle(fontSize: 12)),
              // can add more TextSpans here...
            ],
          ),
        ),
      ],
    );
  }
}
