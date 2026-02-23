import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFFFF8E42);
const Color darkColor = Color(0xFF2D3E50);
const Color grayColor = Color(0xFF9EA7AD);
const Color scaffoldColor = Color(0xFFF6F8FB);
const Color darkScaffoldColor = Color(0xFF121212);

class RestaurantTextStyles {
  static TextTheme get textTheme {
    return TextTheme(
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
        color: darkColor,
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
  }
}

class RestaurantTheme {
  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      hintStyle: GoogleFonts.poppins(color: grayColor),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: grayColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: grayColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: secondaryColor),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: secondaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        onPrimary: darkColor,
        surface: primaryColor,
        background: scaffoldColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: scaffoldColor,
      textTheme: RestaurantTextStyles.textTheme,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: darkColor),
        titleTextStyle: _appBarTheme.titleTextStyle?.copyWith(color: darkColor),
      ),
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        fillColor: primaryColor,
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
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: secondaryColor,
        brightness: Brightness.dark,
        primary: darkColor,
        secondary: secondaryColor,
        onPrimary: Colors.white,
        surface: const Color(0xFF1E1E1E),
      ),
      scaffoldBackgroundColor: darkScaffoldColor,
      textTheme: RestaurantTextStyles.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: darkScaffoldColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: _appBarTheme.titleTextStyle?.copyWith(
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        fillColor: const Color(0xFF1E1E1E),
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
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
  }
}
