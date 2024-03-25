import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';

import '../../styles/text_styles.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  tiles('VISITORS', '140'),

                  const SizedBox(height: 8),
                  tiles('NEW VISITORS', '132'),

                  const SizedBox(height: 8),
                  tiles('BOUNCE RATE', '61.75%'),

                  const SizedBox(height: 8),
                  tiles('SESSIONS', '183'),

                  const SizedBox(height: 8),
                  tiles('AVG SESSION DURATION', '106.46 S'),

                  const SizedBox(height: 15),
                  // How are your visitor trending over time?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How are your visitor trending over time?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // How well you retained the visitors?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How well you retained the visitors?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Where are your users from?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Where are your users from?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // What language do they speak?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What language do they speak?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // What is their age group?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is their age group?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // What is their gender?
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is their gender?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ),
          ),
        )
    );
  }
}
