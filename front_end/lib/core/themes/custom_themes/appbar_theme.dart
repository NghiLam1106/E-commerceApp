import 'package:flutter/material.dart';

class AppBarThemeCustom{
  AppBarThemeCustom._();

  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black,size: 24),
      iconTheme: IconThemeData(size: 24, color: Colors.black)
  );

   static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.white,size: 24),
      iconTheme: IconThemeData(size: 24, color: Colors.white)
  );
}