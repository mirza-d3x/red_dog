import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/common/notification_list_screen.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

import 'features/common/splash_screen.dart';

class RedDogApp extends StatefulWidget {
  @override
  _RedDogAppState createState() => _RedDogAppState();
}

class _RedDogAppState extends State<RedDogApp> {

  @override
  void initState() {
    super.initState();
    initFirebaseMessageListen();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Replace SplashScreen with your actual widget
  }

  void initFirebaseMessageListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (!mounted) return;
      showDialog(
          barrierColor: Colors.white12,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('${event.notification!.title}'),
              content: Text(
                '${event.notification!.body}',
                // style: changeSubText,
                overflow: TextOverflow.fade,
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("View"),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => NotificationListScreen()));
                  },
                )
              ],
            );
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => NotificationListScreen()));
    });
    // FirebaseMessaging.onBackgroundMessage((message) {});
    FirebaseMessaging.onMessage.listen((event) {});
  }
}
