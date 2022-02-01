import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomTitleText({Key? key, required this.text, this.fontSize=30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.specialElite(fontSize: fontSize, color: Colors.white),
    );
  }
}
