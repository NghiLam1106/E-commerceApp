import 'package:flutter/material.dart';
import 'package:front_end/core/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:front_end/core/themes/custom_themes/check_box.dart';
import 'package:front_end/core/themes/custom_themes/chip_theme.dart';
import 'package:front_end/core/themes/custom_themes/elevated_buttons_theme.dart';
import 'package:front_end/core/themes/custom_themes/outlined_button_theme.dart';
import 'package:front_end/core/themes/custom_themes/text_field_theme.dart';
import 'package:front_end/core/themes/custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: AppTextTheme.lightTextTheme,
      chipTheme: AppChipTheme.lightChipTheme,
      bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightTextFormFieldTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      checkboxTheme: AppCheckBoxTheme.lightCheckBoxTheme,
      );
      

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextTheme.darkTextTheme,
      chipTheme: AppChipTheme.darkChipTheme,
      bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkTextFormFieldTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      checkboxTheme: AppCheckBoxTheme.darkCheckBoxTheme,
      );
}
