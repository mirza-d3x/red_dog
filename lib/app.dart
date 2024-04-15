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

  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    initFirebaseMessageListen();
  }

  @override
  void dispose() {
    // Clean up resources
    FirebaseMessaging.onMessage.listen(null);
    FirebaseMessaging.onMessageOpenedApp.listen(null);
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Replace SplashScreen with your actual widget
  }


  void _showForegroundMessage(RemoteMessage message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${message.notification!.title}: ${message.notification!.body}'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => NotificationListScreen()),
            );
          },
        ),
      ),
    );
  }

  void initFirebaseMessageListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages here
      if (message.notification != null) {
        _showForegroundMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle messages opened from the background or terminated app
      if (message.notification != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NotificationListScreen()),
        );
      }
    });
  }

  // void initFirebaseMessageListen() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //     if (!mounted) return;
  //     showDialog(
  //         barrierColor: Colors.white12,
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('${event.notification!.title}'),
  //             content: Text(
  //               '${event.notification!.body}',
  //               // style: changeSubText,
  //               overflow: TextOverflow.fade,
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: Text("Cancel"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text("View"),
  //                 onPressed: () {
  //                   Navigator.pushReplacement(context,
  //                       MaterialPageRoute(builder: (_) => NotificationListScreen()));
  //                 },
  //               )
  //             ],
  //           );
  //         });
  //
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (_) => NotificationListScreen()));
  //   });
  //   // FirebaseMessaging.onBackgroundMessage((message) {});
  //   FirebaseMessaging.onMessage.listen((event) {
  //     if (mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: whiteColor,
  //         behavior: SnackBarBehavior.floating,
  //         // duration: Duration(seconds: 50),
  //         margin: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).size.height-190,
  //             left: 15,
  //             right: 15
  //         ),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               '${event.notification!.title}',
  //               // style: notificationTitleTextStyle
  //             ),
  //             SizedBox(height: 8),  // Add some spacing between lines
  //             Text(
  //               '${event.notification!.body}',
  //               // style: notificationBodyTextStyle,
  //               overflow: TextOverflow.fade,
  //             ),
  //
  //             // SizedBox(height: 8),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 InkWell(
  //                   onTap: (){
  //                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NotificationListScreen()));
  //                   },
  //                   child: Text(
  //                     'View',
  //                     // style: viewButtonTextStyle,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }
}
