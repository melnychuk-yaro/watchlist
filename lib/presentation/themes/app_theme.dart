import 'package:flutter/material.dart';
import 'package:watchlist/presentation/themes/light_theme.dart';

import 'dark_theme.dart';

class AppTheme {
  ThemeData get darkTheme => DarkTheme().themeData;
  ThemeData get lightTheme => LightTheme().themeData;
}
