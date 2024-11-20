import 'package:chess_game_ies/core/routes.dart';
import 'package:flutter/material.dart';

import '../../../presentation/widgets/password_field.dart';
import '../../../presentation/widgets/social_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD6DFFF),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Image.asset("assets/images/signin.png", height: 70.0),
            ),
            const Text("Sign In",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A4ECA))),
            const Text(
              "Welcome back! Sign in to continue.",
              style: TextStyle(fontSize: 14, color: Color(0xFF61677D)),
            ),
            Row(
              children: [
                Expanded(
                    child: SocialButton(
                  icon: "assets/icons/google.png",
                  text: "Google",
                  onPressed: () {},
                )),
                const SizedBox(width: 10.0),
                Expanded(
                  child: SocialButton(
                    icon: "assets/icons/fb.png",
                    text: "Facebook",
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: const Color(0xFFD6DFFF),
                  ),
                ),
                const SizedBox(width: 10.0),
                const Text(
                  "OR",
                  style: TextStyle(color: Color(0xFF61677D)),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: const Color(0xFFD6DFFF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const PasswordField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgotPassword);
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color(0xFF7C8BA0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.chessTimer);
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15.0)),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Color(0xFF7C8BA0)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color(0xFF2A4ECA), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
