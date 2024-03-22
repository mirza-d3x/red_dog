import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/auth/create_analytics_screen.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/features/common/splash_screen.dart';
import 'package:reddog_mobile_app/features/example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: LoginScreen(),
    );
  }
}

