import 'package:flutter/material.dart';

import 'features/common/splash_screen.dart';

class RedDogApp extends StatefulWidget {
  @override
  _RedDogAppState createState() => _RedDogAppState();
}

class _RedDogAppState extends State<RedDogApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
