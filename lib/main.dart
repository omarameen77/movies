import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Movie());
}

class Movie extends StatelessWidget {
  const Movie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeNavBar(),
    );
  }
}
