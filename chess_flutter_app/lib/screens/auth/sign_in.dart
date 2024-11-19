import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/routes.dart';
import '../../widgets/password_field.dart';
import '../../widgets/social_buttons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Store tokens securely
  Future<void> _storeTokens(String token, String refreshToken) async {
    await _secureStorage.write(key: 'token', value: token);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http
          .post(
            Uri.parse("http://10.0.2.2:3000/api/v1/user/sign-in"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 20));

      // Check if the response status is 200 (OK)
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Check if the response contains both token and refreshToken
        if (responseData['token'] != null &&
            responseData['refreshToken'] != null) {
          await _storeTokens(
              responseData['token'], responseData['refreshToken']);
          Navigator.pushNamed(
              context, Routes.home); // Navigate to the home screen
        } else {
          // If tokens are missing, show an error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to retrieve tokens from the server')),
          );
        }
      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Sign-in failed';
        print("Response: ${response.body}");
        print("Error: $errorMessage");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      print("Error: $error");

      if (error is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request timed out. Please try again.')),
        );
      } else if (error is SocketException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Network error. Please check your connection.')),
        );
      } else if (error is FormatException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Received an invalid response from the server.')),
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
                child: Image.asset("assets/images/signin.png", height: 70.0),
              ),
              const Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A4ECA)),
              ),
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
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                    ),
                  ),
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
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              PasswordField(
                passwordController: _passwordController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgotpwd);
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
                      onPressed: _isLoading ? null : _signIn,
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
                              "Sign In",
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
