import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[50],
      fontFamily: 'Nexa',
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
      ))),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(fontSize: 20.0),
      ),
      primaryIconTheme: IconThemeData(color: Colors.black));
}
