import 'package:flutter/material.dart';

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;
  static const grey = Colors.grey;
  static final darkFill = Colors.grey.shade900;
  static final darkSurface = Colors.grey.shade800;
  static final darkBorder = Colors.grey.shade700;
  static final darkHint = Colors.grey.shade400;
}

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  colorScheme: ColorScheme.light(
    primary: AppColors.black,
    onPrimary: AppColors.white,
    surface: AppColors.white,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    titleTextStyle: TextStyle(
      fontSize: 30,
      color: AppColors.black,
      fontWeight: FontWeight.bold,
    ),
    toolbarHeight: 100,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    elevation: 5,
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    hintStyle: TextStyle(color: AppColors.grey),
    labelStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.black, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.black, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      side: const BorderSide(color: AppColors.black),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  colorScheme: ColorScheme.dark(
    primary: AppColors.white,
    onPrimary: AppColors.black,
    surface: AppColors.black,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    titleTextStyle: TextStyle(
      fontSize: 30,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
    toolbarHeight: 100,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    elevation: 5,
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.darkFill,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    hintStyle: TextStyle(color: AppColors.darkHint),
    labelStyle: TextStyle(
      color: AppColors.darkHint,
      fontWeight: FontWeight.bold,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.darkBorder, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.darkBorder, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.darkHint, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.darkBorder, width: 1),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      side: BorderSide(color: Colors.grey.shade300),
    ),
  ),
);
