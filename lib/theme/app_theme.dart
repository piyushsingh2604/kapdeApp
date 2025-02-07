import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final theme = ThemeData(
    textTheme: GoogleFonts.playfairDisplayTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
  );
}
