import 'package:flutter/material.dart';
import 'onboarding/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const AluApp());
}

class AluApp extends StatelessWidget {
  const AluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Intercampus Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'SF Pro Display', // replace with your project font
        colorScheme: ColorScheme.dark(
          primary: AppColors.gold,
          surface: AppColors.background,
        ),
      ),
      home: const LoginScreen(), // ← starts here now
    );
  }
}