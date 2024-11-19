import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/routes.dart';
import '../../widgets/password_field.dart';
import '../../widgets/social_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Basic validation
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http
          .post(
            Uri.parse("http://10.0.2.2:3000/api/v1/user/sign-up"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'fullName': fullName,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10)); // Add a timeout

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Sign-Up Successful: $responseData");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );

        Navigator.pushNamed(context, Routes.home);
      } else {
        final errorData = jsonDecode(response.body);
        print("Error: ${errorData['message'] ?? 'Unknown error occurred'}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Sign-up failed')),
        );
      }
    } catch (error) {
      print("Error details: $error");

      if (error is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request timed out. Please try again.')),
        );
      } else if (error is SocketException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Network error. Please check your connection.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $error')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                controller: _fullNameController,
                keyboardType: TextInputType.text,
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              PasswordField(passwordController: _passwordController),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _isLoading ? null : _signUp,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15.0)),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16.0,
                              ),
                            ),
                    ),
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
                          color: Color(0xFF2A4ECA),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
