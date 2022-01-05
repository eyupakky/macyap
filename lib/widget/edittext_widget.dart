import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class EdittextWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final IconData? icon;
  final IconData? suffixIcon;
  final Color iconColor;
  final Color? sufficIconColor;
  final Color focusColor;
  final FormFieldValidator<String>? validator;
  final Color unFocusColor;
  final Color labelColor;
  final Color textColor;
  final String valid;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final ValueChanged<bool>? onChanged;
  final List<TextInputFormatter>? formatter;
  final bool readOnly;

  const EdittextWidget({
    Key? key,
    required this.controller,
    this.labelText,
    this.icon,
    this.suffixIcon,
    required this.iconColor,
    required this.focusColor,
    required this.unFocusColor,
    required this.labelColor,
    required this.textColor,
    this.valid = "",
    this.hint = "",
    this.obscureText = false,
    this.onChanged,
    this.sufficIconColor = Colors.grey,
    this.keyboardType = TextInputType.text,
    this.maxLength = 20,
    this.validator,
    this.formatter,
    this.readOnly = true,
  }) : super(key: key);

  @override
  State<EdittextWidget> createState() => _EdittextWidgetState();
}

class _EdittextWidgetState extends State<EdittextWidget> {
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        enabled: widget.readOnly,
        inputFormatters: widget.formatter,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        //maxLength: maxLength,
        obscureText: widget.obscureText,
        onChanged: (v) {
          if (widget.valid == "mail") {
            _validate = isEmail(v);
          } else if (widget.valid == "phone") {
            _validate = _phoneNumberValidator(v);
          } else {
            _validate = true;
          }
          if (widget.onChanged != null) {
            widget.onChanged!(_validate);
          }
          setState(() {});
        },
        validator: widget.validator,
        style: TextStyle(
            color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 17),
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.unFocusColor),
            ),
            labelText: widget.labelText,
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 14),
            errorText: !_validate ? 'Bu alan boş olamaz' : null,
            labelStyle: TextStyle(color: widget.labelColor, fontSize: 14),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.focusColor),
            ),
            ),
      ),
    );
  }

  bool _phoneNumberValidator(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
