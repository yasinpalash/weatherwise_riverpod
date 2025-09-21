import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

final darkMode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: AppColors.cloudWhite,
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.deepSky,
    secondary: AppColors.thunderYellow,
    surface: AppColors.darkCloud,
    onPrimary: Colors.white,
    onSecondary: AppColors.nightSky,
    onSurface: AppColors.cloudWhite,
  ),
  scaffoldBackgroundColor: AppColors.nightSky,
);
