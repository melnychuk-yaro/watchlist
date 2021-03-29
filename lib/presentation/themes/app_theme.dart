import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AppTheme {
  ThemeData get darkTheme => DarkTheme().themeData;
  ThemeData get lightTheme => LightTheme().themeData;
}
