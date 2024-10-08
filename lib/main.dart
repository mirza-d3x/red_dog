import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/example_cl_graph.dart';
import 'package:reddog_mobile_app/firebase_options.dart';
import 'package:reddog_mobile_app/providers/acquisition_provider.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/providers/forgot_password_email_provider.dart';
import 'package:reddog_mobile_app/providers/forgot_password_provider.dart';
import 'package:reddog_mobile_app/providers/login_provider.dart';
import 'package:reddog_mobile_app/providers/logout_provider.dart';
import 'package:reddog_mobile_app/providers/notification_provider.dart';
import 'package:reddog_mobile_app/providers/registered_website_provider.dart';
import 'package:reddog_mobile_app/providers/search_provider.dart';
import 'package:reddog_mobile_app/providers/server_provider.dart';
import 'package:reddog_mobile_app/providers/signIn_provider.dart';
import 'package:reddog_mobile_app/providers/user_profile_provider.dart';
import 'package:reddog_mobile_app/providers/visitor_provider.dart';
import 'package:reddog_mobile_app/repositories/acquisition_repository.dart';
import 'package:reddog_mobile_app/repositories/auth_repository.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';
import 'package:reddog_mobile_app/repositories/server_repository.dart';
import 'package:reddog_mobile_app/repositories/user_repository.dart';
import 'package:reddog_mobile_app/repositories/visitor_repository.dart';
import 'package:reddog_mobile_app/utilities/http_ssl_certificate.dart';
import 'package:reddog_mobile_app/utilities/shared_prefernces.dart';
import 'app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpOverrides();
  bool isTokenAvailable = await initApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  messaging.getToken().then((value) {
    setValue('fireBaseToken', value);
    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55');
    print("fireBaseToken   " + value.toString());
  });
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => LoginProvider(authRepository: AuthRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              RegisteredWebsiteProvider(commonRepository: CommonRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              VisitorProvider(visitorRepository: VisitorRepository())),
      ChangeNotifierProvider(
          create: (_) => UserProfileProvider(userRepository: UserRepository())),
      ChangeNotifierProvider(
          create: (_) => ServerProvider(serverRepository: ServerRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              EnquiryProvider(enquiryRepository: EnquiryRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              NotificationProvider(commonRepository: CommonRepository())),
      ChangeNotifierProvider(
          create: (_) => LogoutProvider(commonRepository: CommonRepository())),
      ChangeNotifierProvider(
          create: (_) => AcquisitionProvider(
              acquisitionRepository: AcquisitionRepository())),
      ChangeNotifierProvider(
          create: (_) => SearchProvider(commonRepository: CommonRepository())),
      ChangeNotifierProvider(
          create: (_) => SignInProvider(authRepository: AuthRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              ForgotPasswordEmailProvider(authRepository: AuthRepository())),
      ChangeNotifierProvider(
          create: (_) =>
              ForgotPasswordProvider(authRepository: AuthRepository())),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RedDog',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: RedDogApp(),
    );
  }
}

Future<bool> initApp() async {
  bool isTokenAvailable = false;
  var token = await getValue('token');
  print('@@@@@@@@@@@@@@@@@@@@@JWT Token @@@@@@@@@@@@@@@@@@@@@@@@22');
  print('Access Token ' + token);
  isTokenAvailable = token == '' ? false : true;
  return isTokenAvailable;
}
