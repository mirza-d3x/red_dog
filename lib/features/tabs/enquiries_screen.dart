import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Server'),
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
              ],
            ),
          ),
        )
    );
  }
}
