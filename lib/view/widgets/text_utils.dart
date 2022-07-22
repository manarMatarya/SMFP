import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget TextUtils({
  double fontSize = 25.0,
  FontWeight fontWeight = FontWeight.bold,
  required text,
  Color color = Colors.black,
  TextDecoration underLine = TextDecoration.none,
  TextAlign textAlign = TextAlign.center,
}) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          decoration: underLine,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textAlign: textAlign,
    ),
  );
}
