import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    ),
    cardColor: Colors.grey.shade200,
    highlightColor: Colors.white,
    primaryColorDark: Colors.black,
    brightness: Brightness.light,
    primaryColorLight: const Color(0xFFFB4C5B),
    primaryColor: const Color(0xFF00008F),
    backgroundColor: const Color(0xFFFB4C5B),
    textTheme: TextTheme(
      headline1: const TextStyle(
          fontFamily: 'brandon_H', fontSize: 30, color: Colors.black),
      headline2: GoogleFonts.montserrat(),
      headline5: GoogleFonts.montserrat(fontSize: 17),
      headline6: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17),
      bodyText2: GoogleFonts.poppins(),
      bodyText1: GoogleFonts.poppins(),
      subtitle1: GoogleFonts.poppins(fontSize: 14),
      subtitle2: GoogleFonts.poppins(fontSize: 14, color: Colors.blue),
    ),
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFFB4C5B),
      primaryColorLight: const Color(0xFF04FBC3),
      backgroundColor: const Color(0xFFFB4C5B),
      //highlightColor: const Color(0xFFFB4C5B),
      primaryColorDark: Colors.white,
      cardColor: Colors.grey.shade900,
      textTheme: TextTheme(
        headline1: const TextStyle(
            fontFamily: 'brandon_H', fontSize: 30, color: Colors.white),
        headline2: GoogleFonts.montserrat(),
        headline5: GoogleFonts.montserrat(fontSize: 15),
        headline6:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17),
        bodyText1: GoogleFonts.poppins(),
        bodyText2: GoogleFonts.poppins(),
        subtitle1: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        subtitle2: GoogleFonts.poppins(fontSize: 14, color: Colors.blue),
      ));
}

const mainBgColor = Color(0xFFf2f2f2);
const darkColor = Color(0xFF2A0B35);
const midColor = Color(0xFF522349);
const lightColor = Color(0xFFA52C4D);
const darkRedColor = Color(0xFFFA695C);
const lightRedColor = Color(0xFFFD685A);

const purpleGradient = LinearGradient(
  colors: <Color>[darkColor, midColor, lightColor],
  stops: [0.0, 0.5, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const redGradient = LinearGradient(
  colors: <Color>[darkRedColor, lightRedColor],
  stops: [0.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
