import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      // colorScheme: const ColorScheme(
      //   primary: CustomColors.orange,
      //   background: Colors.white,
      //   secondary: Colors.white,
      //   brightness: Brightness.dark,
      //   onError: Colors.red,
      //   error: Colors.red,
      //   secondaryVariant: Colors.white,
      //   primaryVariant: Colors.orange,
      //   surface: CustomColors.orange, //checked
      //   onSecondary: Colors.white,
      //   onPrimary: Colors.orange,
      //   onBackground: Colors.white,
      //   onSurface: Colors.white, // checked
      // ),
      primaryColor: CustomColors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomColors.orange
        ),
        scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.orange,
      )
    );
  }
}