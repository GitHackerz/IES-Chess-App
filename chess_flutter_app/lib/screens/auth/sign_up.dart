import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../widgets/password_field.dart';
import '../../widgets/social_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              child: Image.asset("assets/images/signup.png", height: 70.0),
            ),
            const Text("Sign Up",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A4ECA))),
            const Text(
              "Create an account to continue.",
              style: TextStyle(fontSize: 14, color: Color(0xFF61677D)),
            ),
            const SizedBox(height: 20.0),
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
                hintText: "Full Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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
            const SizedBox(height: 20.0),
            const PasswordField(),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15.0)),
                      ),
                      child: const Text(
                        "Sign Up",
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
                  "Already have an account?",
                  style: TextStyle(color: Color(0xFF7C8BA0)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signIn);
                  },
                  child: const Text(
                    "Sign In",
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
