import 'package:flutter/material.dart';
import 'package:flutter_task_manager/styles/colors.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: appBarTheme,
  scaffoldBackgroundColor: AppColors.white,
  textTheme: textTheme,
  floatingActionButtonTheme: floatingActionButtonTheme,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
  bottomSheetTheme: bottomSheetTheme,
  inputDecorationTheme: inputDecorationTheme,
  textSelectionTheme: textSelectionTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  dialogTheme: dialogTheme,
  cardTheme: cardTheme,
  dividerColor: AppColors.black,
  iconTheme: iconTheme,
  textButtonTheme: textButtonTheme,
  colorScheme: colorScheme,
);

final IconThemeData iconTheme = IconThemeData(color: AppColors.black);

final ColorScheme colorScheme = ColorScheme.light(
  primary: AppColors.black,
  onPrimary: AppColors.white,
  surface: AppColors.white,
  onSurface: AppColors.black,
  secondary: AppColors.lightGrey,
  onSecondary: AppColors.black,
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: Colors.black),
);

final CardThemeData cardTheme = CardThemeData(
  color: AppColors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: AppColors.black),
  ),
);

final DialogThemeData dialogTheme = DialogThemeData(
  backgroundColor: AppColors.white,
  titleTextStyle: TextStyle(
    color: AppColors.black,
    fontSize: 22,
    fontWeight: FontWeight.w400,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
  ),
);

final OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    side: BorderSide(color: AppColors.black),
  ),
);

const TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
  cursorColor: AppColors.darkGrey,
);

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  errorStyle: TextStyle(color: AppColors.lightGrey),
  filled: true,
  fillColor: AppColors.white,
  hintStyle: TextStyle(color: AppColors.lightGrey),
  labelStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.black, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.black, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.black, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.black, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.black, width: 1),
  ),
);

BottomSheetThemeData bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: AppColors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

const BottomNavigationBarThemeData bottomNavigationBarTheme =
    BottomNavigationBarThemeData(
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.black,
      backgroundColor: AppColors.white,
    );

const FloatingActionButtonThemeData floatingActionButtonTheme =
    FloatingActionButtonThemeData(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 5,
    );

const AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0,
  backgroundColor: AppColors.white,
  foregroundColor: AppColors.black,
  titleTextStyle: TextStyle(
    fontSize: 30,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  ),
  toolbarHeight: 100,
);

const TextTheme textTheme = TextTheme(
  bodyLarge: TextStyle(color: Colors.black),
  bodyMedium: TextStyle(color: Colors.black),
  bodySmall: TextStyle(color: Colors.black),
  titleLarge: TextStyle(color: Colors.black),
  titleMedium: TextStyle(color: Colors.black),
  titleSmall: TextStyle(color: Colors.black),
  labelLarge: TextStyle(color: Colors.black),
  labelMedium: TextStyle(color: Colors.black),
  labelSmall: TextStyle(color: Colors.black),
);
