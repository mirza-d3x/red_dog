import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

import '../../styles/text_styles.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: whiteColor,
            leading: const Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            titleSpacing: 0,
            title: Text(
              'Notifications',
              style: appBarTitleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context,index) => Column(
                  children: [
                    Card(
                      elevation: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: whiteColor
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: lightRedColor,
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: blackColor,
                            ),
                          ),

                          title: Text(
                            'Notification Title'
                          ),

                          subtitle: Text(
                            'Notification content'
                          ),

                          trailing: Text(
                            '1 Hr Ago'
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
            ),
          ),
        ),
    );
  }
}
