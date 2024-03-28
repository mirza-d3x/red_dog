import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/tiles.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Acquisition'),
          backgroundColor: bgColor,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // drop dwn menu,calander,download button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: blackColor,
                            ),
                            // iconSize: 0,
                            hint: selectedWebsite == null
                                ? Row(
                              children: [
                                Text(
                                    'Aladdinpro - GA4',
                                    style: dropDownTextStyle
                                ),

                                const SizedBox(width: 10),
                              ],
                            )
                                : Row(
                              children: [
                                Text(
                                    selectedWebsite,
                                    style: dropDownTextStyle
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            value: selectedWebsite,
                            onChanged: (newValue) {
                              setState(() {
                                isSelectedFromDropDwn = true;
                                selectedWebsite = newValue;
                              });
                            },
                            items: [
                              'Codelattice',
                              'Alddinpro - GA4',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: dropDownTextStyle
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 0),

                    Card(
                      elevation: 2,
                      child: Container(
                          height: 43,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            color: blackColor,
                            size: 20,
                          )
                      ),
                    ),

                    const SizedBox(width: 0),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Card(
                        elevation: 2,
                        child: Container(
                            height: 43,
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.download,
                              color: blackColor,
                              size: 20,
                            )
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tiles(context,'Average page load time', '6.03 ms'),
                    tiles(context,'Average server response time', '0.47 ms'),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tiles(context,'Average server latency', '6.03 ms'),
                    Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Content',
                                  style: tileTitleTextStyle,
                                ),
                                Text(
                                  'load time',
                                  style: tileTitleTextStyle,
                                )
                              ],
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '0.47 ms',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    )
                    // tiles(context,'Content load time', '0.47 ms'),
                  ],
                ),

                const SizedBox(height: 8),

                Card(
                  elevation: 2,
                  shadowColor: whiteColor,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uptime',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '67.65%',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),

                        Image.asset(
                          'assets/images/server_uptime.PNG',
                          height: 50,
                        )
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
