import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

final lightMode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.stormBlue,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.stormBlue,
      secondary: AppColors.thunderYellow,
      surface: AppColors.cloudWhite,
      onPrimary: Colors.white,
      onSecondary: AppColors.stormBlue,
      onSurface: AppColors.stormBlue,
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA));
