import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const white = Colors.white;
const black = Colors.black;
const kTextColor = Color(0xff08110C);
const kPrimaryBlack = Color(0xff05140E);

ThemeData get appTheme {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.poppinsTextTheme(),
    primaryColor: black,
    cardColor: Colors.transparent,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: white,
    ),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  );
}
