import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/tabView_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String storedToken = '';

  @override
  void initState() {
    super.initState();
    // getAccessToken();
    Timer(const Duration(seconds: 1), () {
      if(storedToken.isEmpty){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const LoginScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  TabViewScreen()));
      }
    });
  }

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
