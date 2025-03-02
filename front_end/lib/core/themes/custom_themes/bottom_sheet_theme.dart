import 'package:flutter/material.dart';

class AppBottomSheetTheme{
  AppBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      constraints: const BoxConstraints(minWidth: double.infinity)
  );

   static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
          showDragHandle: true,
      backgroundColor: Colors.black,
      modalBackgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      constraints: const BoxConstraints(minWidth: double.infinity)
  );
}