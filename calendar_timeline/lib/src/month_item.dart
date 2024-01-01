import 'package:flutter/material.dart';

/// Creates a Widget to represent the months.
class MonthItem extends StatelessWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  final Color? color;
  final int alpha;
  final double fontSize;

  MonthItem(
      {required this.name,
      required this.onTap,
      this.isSelected = false,
      this.alpha = 150,
      this.color,
      this.fontSize=14});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap as void Function()?,
      child: Text(
        this.name.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          color: this.isSelected ? color : color!.withAlpha(alpha),
          fontWeight: this.isSelected ? FontWeight.bold : FontWeight.w300,
        ),
      ),
    );
  }
}
