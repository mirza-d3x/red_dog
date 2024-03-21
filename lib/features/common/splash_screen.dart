import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: loginBgColor,
          body: Center(
            child: Image.asset(
              'assets/images/redDog_logo.png',
              height: 40,
            ),
          ),
        )
    );
  }
}
