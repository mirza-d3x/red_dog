import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/tabs/acquisition_screen.dart';
import 'package:reddog_mobile_app/features/tabs/enquiries_screen.dart';
import 'package:reddog_mobile_app/features/tabs/server_screen.dart';
import 'package:reddog_mobile_app/features/tabs/visitors_screen.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

class TabViewScreen extends StatefulWidget {
   TabViewScreen(
      {super.key});

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: tabIndex,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
              VisitorsScreen(),
              AcquisitionScreen(),
             const ServerScreen(),
             const EnquiryScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorSize: TabBarIndicatorSize.tab, // Set indicator size to tab
          indicator: const BoxDecoration(
            color: loginBgColor,
            borderRadius: BorderRadius.zero,
          ),
          unselectedLabelColor: blackColor,
          labelColor: whiteColor,
          tabs: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Container(
                height: 45,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                        Icons.remove_red_eye_outlined
                    ),
                    Text('Visitors',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Barlow-Medium'
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Container(
                height: 45,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.home),
                    Text('Acquisition',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Barlow-Medium'
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Container(
                height: 45,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.layers_alt
                    ),
                    Text('Server',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Barlow-Medium'
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Container(
                height: 45,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.waveform_path_ecg
                        // Icons.legend_toggle_outlined
                    ),
                    Text('Enquiries',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Barlow-Medium'
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
