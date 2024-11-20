import 'package:chess_game_ies/presentation/views/auth/forgot_password.dart';
import 'package:chess_game_ies/presentation/views/auth/sign_in.dart';
import 'package:chess_game_ies/presentation/views/auth/sign_up.dart';
import 'package:chess_game_ies/presentation/views/chat.dart';
import 'package:chess_game_ies/presentation/views/chess_timer.dart';
import 'package:chess_game_ies/presentation/views/matches.dart';
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
        Routes.signIn: (context) => const SignInScreen(),
        Routes.signUp: (context) => const SignUpScreen(),
        Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
        Routes.chessTimer: (context) => ChessTimerScreen(),
        Routes.matches: (context) => ChessMatchListScreen(),
        Routes.chatbot: (context) => ChatbotScreen(),
      },
      initialRoute: Routes.chatbot,
    );
  }
}
