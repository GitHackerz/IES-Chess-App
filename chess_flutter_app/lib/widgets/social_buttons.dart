import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          backgroundColor: const Color(0xFFEFEFEF)),
      child: Row(
        children: [
          Image.asset(icon, height: 24.0),
          const SizedBox(width: 16.0),
          Text(
            text,
            style: const TextStyle(color: Color(0xFF61677D), fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
