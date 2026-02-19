import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFFFF8E42);
const Color darkColor = Color(0xFF2D3E50);
const Color grayColor = Color(0xFF9EA7AD);
const Color scaffoldColor = Color(0xFFF6F8FB);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: darkColor,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: darkColor,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: darkColor,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: darkColor,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: darkColor,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: darkColor,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: darkColor,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: darkColor,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: darkColor, // Default text body
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: darkColor,
  ),
  labelLarge: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: darkColor,
  ),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: secondaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    onPrimary: darkColor,
    surface: primaryColor,
    background: scaffoldColor,
  ),
  scaffoldBackgroundColor: scaffoldColor,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: darkColor),
    titleTextStyle: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.poppins(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF121212),

  colorScheme: ColorScheme.fromSeed(
    seedColor: secondaryColor,
    brightness: Brightness.dark,
    primary: darkColor,
    secondary: secondaryColor,
    onPrimary: Colors.white,
    surface: const Color(0xFF1E1E1E),
  ),

  textTheme: myTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF121212),
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.poppins(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
