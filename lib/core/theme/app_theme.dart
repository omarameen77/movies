import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColor,
    canvasColor: AppColors.blackTwo,
    primaryColor: AppColors.gold,

    fontFamily: "Cairo",
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(0, 96, 72, 72),
      centerTitle: true,
      elevation: 0,
    ),

    hoverColor: AppColors.gold,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.gray,
      selectedIconTheme: IconThemeData(size: 26),
      unselectedIconTheme: IconThemeData(size: 22),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      displayMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      displaySmall: TextStyle(color: AppColors.white, fontSize: 18),
      headlineMedium: TextStyle(
        color: AppColors.gray,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      headlineLarge: TextStyle(
        color: AppColors.gray,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineSmall: TextStyle(color: AppColors.gray, fontSize: 18),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.gray,
      ),

      labelMedium: TextStyle (
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
  );
}
