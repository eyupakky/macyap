import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({
    super.key,
    required this.controller,
    required this.validate,
    this.hintText,
    this.textInputType,
    required this.icon,
    this.suffixIcon,
    this.textInputAction,
    this.focusNode,
    this.validator,
  });

  final TextEditingController controller;
  final AutovalidateMode validate;
  final String? hintText;
  final TextInputType? textInputType;
  final IconData icon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FadeInRight(
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          autovalidateMode: validate,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          validator: validator,
          obscureText: true,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            focusColor: Colors.black,
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
