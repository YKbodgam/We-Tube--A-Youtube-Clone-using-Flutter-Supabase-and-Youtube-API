import 'package:flutter/material.dart';

import 'home_screen.dart';
import '../utils/colours.dart';
import '../constants/rounded_button.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RoundedButton(
              text: "Continue",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
