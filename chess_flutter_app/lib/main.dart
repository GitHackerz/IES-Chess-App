import 'package:chess_game_ies/screens/auth/sign_in.dart';
import 'package:chess_game_ies/screens/auth/sign_up.dart';
import 'package:chess_game_ies/screens/home.dart';
import 'package:chess_game_ies/screens/intro.dart';
import 'package:flutter/material.dart';

import 'core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFF2C3E50),
          onPrimary: const Color(0xFFFFFFFF),
          seedColor: const Color(0xFFB58863),
          secondary: const Color(0xFFD2B48C),
          onSecondary: const Color(0xFF2C3E50),
          surface: const Color(0xFFF5F5F5),
          onSurface: const Color(0xFF4E342E),
        ),
        useMaterial3: true,
      ),
      routes: {
        Routes.intro: (context) => const IntroScreen(),
        Routes.signIn: (context) => const SignInScreen(),
        Routes.signUp: (context) => const SignUpScreen(),
      },
      initialRoute: Routes.intro,
    );
  }
}
