import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;
  const CustomButton({Key? key, required this.text, required this.onPressed,
    this.width=200,this.height=50,
    this.fontSize=25
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(colors: [Colors.grey, Colors.black, Colors.white])),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.specialElite(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}
