import 'package:flutter/material.dart';

import 'radio_button.dart';
import 'radio_button_builder.dart';
import 'radio_button_text_position.dart';

class RadioGroup<T> extends StatelessWidget {
  /// Creates a [RadioButton] group
  ///
  /// The [groupValue] is the selected value.
  /// The [items] are elements to contruct the group
  /// [onChanged] will called every time a radio is selected. The clouser return the selected item.
  /// [direction] most be horizontal or vertial.
  /// [spacebetween] works only when [direction] is [Axis.vertical] and ignored when [Axis.horizontal].
  /// and represent the space between elements
  /// [horizontalAlignment] works only when [direction] is [Axis.horizontal] and ignored when [Axis.vertical].
  final T groupValue;
  final List<T> items;
  final RadioButtonBuilder Function(T value) itemBuilder;
  final void Function(T?)? onChanged;
  final Axis direction;
  final double spacebetween;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final MainAxisAlignment horizontalAlignment;
  final Color? activeColor;

   RadioGroup.builder({
    required this.groupValue,
    required this.onChanged,
    required this.items,
    required this.itemBuilder,
    this.leftMargin = 0,
     this.rightMargin = 0,
     this.topMargin= 0,
     this.bottomMargin=0,
    this.direction = Axis.vertical,
    this.spacebetween = 30,
    this.horizontalAlignment = MainAxisAlignment.spaceBetween,
    this.activeColor,
  });

  List<Widget> get _group => this.items.map(
        (item) {
          final radioButtonBuilder = this.itemBuilder(item);

          return Container(
            margin: EdgeInsets.only(
                left: leftMargin,
                right: rightMargin,
                top: topMargin,
                bottom: bottomMargin),
            height: this.direction == Axis.vertical ? this.spacebetween : 40.0,
            child: RadioButton(
              description: radioButtonBuilder.description,
              value: item,
              groupValue: this.groupValue,
              onChanged: this.onChanged,
              textPosition: radioButtonBuilder.textPosition ??
                  RadioButtonTextPosition.right,
              activeColor: activeColor,
            ),
          );
        },
      ).toList();

  @override
  Widget build(BuildContext context) => this.direction == Axis.vertical
      ? Column(
          children: _group,
        )
      : Row(
          mainAxisAlignment: this.horizontalAlignment,
          children: _group,
        );
}
