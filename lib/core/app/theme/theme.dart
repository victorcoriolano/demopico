import 'package:flutter/material.dart';

// ==== Core Palette ====
const Color kRed = Color(0xFF8B0000);
const Color kRedAccent = Color(0xFFD32F2F);
const Color kLightRed = Color(0xFFC62828);
const Color kError = Color(0xFFB00020);

// ==== Neutrals ====
const Color kBlack = Color(0xFF000000);
const Color kDarkGrey = Color(0xFF1F1D1D);
const Color kMediumGrey = Color.fromARGB(255, 169, 168, 168);
const Color kLightGrey = Color.fromARGB(255, 206, 205, 205);
const Color kAlmostWhite = Color.fromARGB(255, 217, 217, 217);
const Color kWhite = Colors.white;

// ==== Backgrounds ====
const Color kBackground = kAlmostWhite;
const Color kSurface = kLightGrey;
const Color kCardBackground = kMediumGrey;
const Color kDialogBackground = kAlmostWhite;

// ==== Text ====
const Color kTextPrimary = kBlack;
const Color kTextSecondary = kDarkGrey;
const Color kTextOnRed = kWhite;


final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: kRed,
  

  colorScheme:  ColorScheme.fromSeed(
    seedColor: kRed,
    
    brightness: Brightness.light,

    primary: kRed,
    onPrimary: kAlmostWhite,
    secondary: kRedAccent,
    onSecondary: kAlmostWhite,
    error: kError,
    onError: kAlmostWhite,
    surface: kSurface,
    onSurface: kBlack,
  ),

  scaffoldBackgroundColor: kAlmostWhite,

  appBarTheme: const AppBarTheme(
    backgroundColor: kRed,
    foregroundColor: kAlmostWhite,
    elevation: 1,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: kTextPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: kTextSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: kTextSecondary,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kRed,
      foregroundColor: kAlmostWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  iconTheme: const IconThemeData(
    color: kRed,
  ),

  cardTheme: CardTheme(
    color: kLightGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  dialogTheme: const DialogTheme(
    backgroundColor: kDialogBackground,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kTextPrimary,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16,
      color: kTextSecondary,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kBackground,
    unselectedItemColor: kDarkGrey,
    elevation: 3
  )
);
