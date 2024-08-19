import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameController,
    required this.validate,
    this.hintText,
    this.textInputType,
    required this.icon,
    this.textInputAction,
  });

  final TextEditingController nameController;
  final AutovalidateMode validate;
  final String? hintText;
  final TextInputType? textInputType;
  final IconData icon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FadeInRight(
        child: TextFormField(
          controller: nameController,
          autovalidateMode: validate,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
            ),
            focusColor: Colors.black,
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
