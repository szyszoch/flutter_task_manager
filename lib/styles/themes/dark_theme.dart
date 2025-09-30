import 'package:flutter/material.dart';
import 'package:flutter_task_manager/styles/colors.dart';

final ThemeData darkTheme = ThemeData(
  appBarTheme: appBarTheme,
  scaffoldBackgroundColor: AppColors.black,
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
  dividerColor: AppColors.white,
  iconTheme: iconTheme,
  textButtonTheme: textButtonTheme,
  colorScheme: colorScheme,
);

final IconThemeData iconTheme = IconThemeData(color: AppColors.white);

final ColorScheme colorScheme = ColorScheme.dark(
  primary: AppColors.white,
  onPrimary: AppColors.black,
  surface: AppColors.darkerGrey,
  onSurface: AppColors.white,
  secondary: AppColors.lighterGrey,
  onSecondary: AppColors.white,
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: Colors.white),
);

final CardThemeData cardTheme = CardThemeData(
  color: AppColors.darkGrey,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: AppColors.lightGrey),
  ),
);

final DialogThemeData dialogTheme = DialogThemeData(
  backgroundColor: AppColors.darkGrey,
  titleTextStyle: TextStyle(
    color: AppColors.white,
    fontSize: 22,
    fontWeight: FontWeight.w400,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
  ),
);

final OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: AppColors.white,
    side: BorderSide(color: AppColors.white),
  ),
);

const TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
  cursorColor: AppColors.lighterGrey,
);

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  errorStyle: TextStyle(color: AppColors.lightGrey),
  filled: true,
  fillColor: AppColors.darkGrey,
  hintStyle: TextStyle(color: AppColors.lightGrey),
  labelStyle: TextStyle(
    color: AppColors.lighterGrey,
    fontWeight: FontWeight.bold,
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
  ),
);

BottomSheetThemeData bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: AppColors.darkerGrey,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

const BottomNavigationBarThemeData bottomNavigationBarTheme =
    BottomNavigationBarThemeData(
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
      backgroundColor: AppColors.black,
    );

const FloatingActionButtonThemeData floatingActionButtonTheme =
    FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      elevation: 5,
    );

const AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0,
  backgroundColor: AppColors.black,
  foregroundColor: AppColors.white,
  titleTextStyle: TextStyle(
    fontSize: 30,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  ),
  toolbarHeight: 100,
);

const TextTheme textTheme = TextTheme(
  bodyLarge: TextStyle(color: Colors.white),
  bodyMedium: TextStyle(color: Colors.white),
  bodySmall: TextStyle(color: Colors.white),
  titleLarge: TextStyle(color: Colors.white),
  titleMedium: TextStyle(color: Colors.white),
  titleSmall: TextStyle(color: Colors.white),
  labelLarge: TextStyle(color: Colors.white),
  labelMedium: TextStyle(color: Colors.white),
  labelSmall: TextStyle(color: Colors.white),
);
