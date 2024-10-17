import 'package:flutter/material.dart';

class AppColorTheme {
  static const Color primaryColor = Color(0xFF024959);
  static const Color secondaryColor = Color(0xFF049DBF);
  static const Color tertiaryColor = Color(0xFF04C4D9);
  static const Color primaryBackgroundClear = Color(0xFFD9CAC5);
  static const Color secondaryBackgroundClear = Color(0xFFA6695B);

  static WidgetStateProperty<Color> primaryColorProperty =
      WidgetStateProperty.all(AppColorTheme.primaryColor);

  static WidgetStateProperty<Color> secondaryColorProperty =
      WidgetStateProperty.all(AppColorTheme.secondaryColor);

  static WidgetStateProperty<Color> tertiaryColorProperty =
      WidgetStateProperty.all(AppColorTheme.tertiaryColor);

  static WidgetStateProperty<Color> primaryBackgroundClearProperty =
      WidgetStateProperty.all(AppColorTheme.primaryBackgroundClear);

  static WidgetStateProperty<Color> secondaryBackgroundClearProperty =
      WidgetStateProperty.all(AppColorTheme.secondaryBackgroundClear);
}
