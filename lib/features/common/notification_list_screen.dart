import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/providers/notification_provider.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/ui_state.dart';
import '../../styles/text_styles.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {

  NotificationProvider notificationProvider = NotificationProvider(commonRepository: CommonRepository());

  @override
  void initState(){
    super.initState();
    notificationProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: whiteColor,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: blackColor,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              'Notifications',
              style: appBarTitleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: notificationWidget(),
            // ListView.builder(
            //   physics: const AlwaysScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 10,
            //     itemBuilder: (context,index) => Column(
            //       children: [
            //         Card(
            //           elevation: 1,
            //           child: Container(
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(2),
            //               color: whiteColor
            //             ),
            //             child: ListTile(
            //               leading: const CircleAvatar(
            //                 backgroundColor: lightRedColor,
            //                 child: Icon(
            //                   Icons.notifications_none_outlined,
            //                   color: blackColor,
            //                 ),
            //               ),
            //
            //               title: Text(
            //                 'Notification Title',
            //                 style: notificationTitleTextStyle,
            //               ),
            //
            //               subtitle: Text(
            //                 'Notification content',
            //                 style: notificationTextStyle,
            //               ),
            //
            //               trailing: Text(
            //                 '1 Hr Ago',
            //                 style: notificationTextStyle,
            //               ),
            //             ),
            //           ),
            //         ),
            //
            //         const SizedBox(height: 8),
            //       ],
            //     ),
            // ),
          ),
        ),
    );
  }

  Widget notificationWidget() {
    return ChangeNotifierProvider<NotificationProvider>(
      create: (ctx) {
        return notificationProvider;
      },
      child: Consumer<NotificationProvider>(builder: (ctx, data, _) {
        var state = data.notificationListLiveData().getValue();
        print(state);
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: CircularProgressIndicator(
                color: loginBgColor,
              ),
            ),
          );
        } else if (state is Success) {
          return  ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.getNotificationModel.notifications!.length,
              itemBuilder: (context,index) => Column(
                children: [
                  Card(
                    elevation: 1,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10,top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: whiteColor
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: lightRedColor,
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: blackColor,
                          ),
                        ),

                        title: Text(
                          '${data.getNotificationModel.notifications![index].title}',
                          style: notificationTitleTextStyle,
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.getNotificationModel.notifications![index].description}'
                                    .replaceAll(RegExp(
                                    r'http[s]?:\/\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'),
                                    ''),
                                style: notificationTextStyle,
                              ),

                          const SizedBox(height: 2),
                          InkWell(
                            onTap: (){
                              launch('${data.getNotificationModel.notifications![index].url}');
                            },
                            child: Text(
                              '${data.getNotificationModel.notifications![index].url}',
                              style: notificationUrlTextStyle,
                            ),
                          ),

                          const SizedBox(height: 5),
                          Text(
                              timeAgoSinceDate(
                                '${data.getNotificationModel.notifications![index].createdDate}'
                              ),
                              style: notificationTextStyle,
                            ),
                            ],
                          ),
                        ),

                        // trailing: Text(
                        //   timeAgoSinceDate(
                        //     '${data.getNotificationModel.notifications![index].createdDate}'
                        //   ),
                        //   style: notificationTextStyle,
                        // ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
          );
        } else if (state is Failure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text(
                'No Notifications',
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  timeAgoSinceDate(dynamic apiDate){

    DateTime postCreateDate = DateTime.parse(apiDate);
    final date2 = DateTime.now();
    final diff = date2.difference(postCreateDate);

    // if(diff.inHours > 8)
    //   return DateFormat("dd:MM:yyyy HH:mm:ss").format(postCreateDate);
    if((diff.inDays / 7).floor() ==1)
      return "1 week ago";
    else if((diff.inDays / 7).floor() == 2)
      return "2 weeks ago";
    else if((diff.inDays / 7).floor() == 3)
      return "3 weeks ago";
    else if((diff.inDays / 7).floor() == 4)
      return "4 weeks ago";
    else if(diff.inDays > 1 && diff.inDays < 6)
      return "${diff.inDays} days ago";
    else if((diff.inDays / 30).floor() >= 1)
      return "${(diff.inDays / 30).truncate()} month ago";
    else if(diff.inDays >=1 )
      return "1 day ago";
    else if(diff.inHours >= 2)
      return "${diff.inHours} hours ago";
    else if(diff.inHours >=1)
      return "1 hour ago";
    else if(diff.inMinutes >= 2)
      return "${diff.inMinutes} minutes ago";
    else if(diff.inMinutes >= 1)
      return "1 minute ago";
    else if(diff.inSeconds >= 3)
      return "${diff.inSeconds} seconds ago";
    else
      return 'Just now';

    // return DateFormat();
  }

  String formatDateFromAPI(dynamic apiDate) {
    DateTime? date = DateTime.tryParse(apiDate);
    final formattedDate =
    // DateFormat(DateFormat.YEAR_MONTH_DAY).format(apiDate));
    //   print(formattedDate);
    DateFormat('d').format(date!) + ' ' + DateFormat('LLL').format(date) +' ' + DateFormat('y').format(date);
    return formattedDate;
  }
}
