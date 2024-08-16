import 'package:flutter/material.dart';

class RegisterDot extends StatelessWidget {
  final Color color;
  final double width;
  const RegisterDot({
    super.key,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 10,
      margin: const EdgeInsets.all(2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
