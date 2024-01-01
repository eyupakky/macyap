import 'package:flutter/material.dart';

/// Creates a Widget representing the day.
class DayItem extends StatelessWidget {
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final Function onTap;
  final Color? dayColor;
  final double? fontSize;
  final Color? activeDayColor;
  final Color? activeDayBackgroundColor;
  final bool available;
  final Color? dotsColor;
  final Color? dayNameColor;
  final double? height;
  final double? width;
  final double? dayFontSize;
  const DayItem({
    Key? key,
    required this.dayNumber,
    required this.shortName,
    required this.onTap,
    this.isSelected = false,
    this.dayColor,
    this.activeDayColor,
    this.activeDayBackgroundColor,
    this.available = true,
    this.dotsColor,
    this.dayNameColor, this.fontSize,this.height,this.width,this.dayFontSize
  }) : super(key: key);

  _buildDay(BuildContext context) {
    final textStyle = TextStyle(
      color: available
        ? dayColor ?? Theme.of(context).colorScheme.secondary
        : dayColor?.withOpacity(0.5) ??
        Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      fontSize: fontSize??22,
      fontWeight: FontWeight.normal);
    final selectedStyle = TextStyle(
      color: activeDayColor ?? Colors.white,
      fontSize: fontSize??22,
      fontWeight: FontWeight.bold,
      height: 0.8,
    );

    return GestureDetector(
      onTap: available ? onTap as void Function()? : null,
      child: Container(
        decoration: isSelected
          ? BoxDecoration(
          color:
          activeDayBackgroundColor ?? Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.0),
        )
          : BoxDecoration(color: Colors.transparent),
        height: height??70,
        width: width??60,
        child: Column(
          children: <Widget>[
            if (isSelected) ...[
              SizedBox(height: 7),
              _buildDots(),
              SizedBox(height: 12),
            ] else
              SizedBox(height: 14),
            Text(
              dayNumber.toString(),
              style: isSelected ? selectedStyle : textStyle,
            ),
              Text(
                shortName,
                style: TextStyle(
                  color: dayNameColor ?? activeDayColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: dayFontSize??14,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    final dot = Container(
      height: 5,
      width: 5,
      decoration: new BoxDecoration(
        color: this.dotsColor ?? this.activeDayColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [dot, dot],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDay(context);
  }
}