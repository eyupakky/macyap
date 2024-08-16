import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/hex_color.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 120,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 90,
                child: Text(
                  "ÜYE GİRİŞİ   ",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              size: 24,
              color: HexColor.fromHex("#f0243a"),
            ),
          ],
        ),
      ),
    );
  }
}
