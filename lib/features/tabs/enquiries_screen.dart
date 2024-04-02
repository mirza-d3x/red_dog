import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reddog_mobile_app/widgets/infotiles.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/tiles.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

  dynamic _selectedFromDate;
  dynamic _selectedToDate;

  void _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: _selectedFromDate != null && _selectedToDate != null
          ? DateTimeRange(start: _selectedFromDate, end: _selectedToDate)
          : DateTimeRange(start: DateTime(2024, 3, 3), end: DateTime.now()),
    );

    if (picked != null) {
      setState(() {
        _selectedFromDate = picked.start;
        _selectedToDate = picked.end;
      });
    }
  }

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Enquiries'),
          backgroundColor: bgColor,
          body:
          // noEnquiryWidget(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // drop dwn menu,calander,download button
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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

                      InkWell(
                        onTap: () =>  _selectDateRange(context),
                        child: Card(
                          elevation: 2,
                          child: Container(
                              height: 43,
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:
                              Center(
                                child: Text(
                                  _selectedFromDate != null && _selectedToDate != null ?
                                  '${DateFormat('yyyy-MM-dd').format(_selectedFromDate) } to ${DateFormat('yyyy-MM-dd').format(_selectedToDate)}'
                                  // ? '${_selectedFromDate.toString()} To: ${_selectedToDate.toString()}'
                                      : '2024-03-03 to ${formattedDate}',
                                  style: dropDownTextStyle,
                                ),
                              ),
                              // const Icon(
                              //   Icons.calendar_month,
                              //   color: blackColor,
                              //   size: 20,
                              // )
                          ),
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
                ),

                const SizedBox(height: 10),

                // Tiles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Infoiles(context, 'Total', '356'),
                  Infoiles(context, 'Contact Us', '56'),
                  Infoiles(context, 'Ask Us', '32')
                ],
              ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tiles(context,'Carriers', '137'),
                    tiles(context,'Register', '131'),
                  ],
                ),

                const SizedBox(height: 15),

              // List
                Text(
                  'Lead Details',
                  style: normalTextStyle,
                ),

                const SizedBox(height: 10),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Viswarag C M',
                                        style: nameTextStyle,
                                      ),

                                      const SizedBox(height: 8),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.email_outlined,
                                            size: 15,
                                            color: titleTextColor,
                                          ),

                                          const SizedBox(width: 5),

                                          Text(
                                              'cmviswarag@gmail.com',
                                            style: subTextTextStyle,
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone_enabled,
                                            size: 15,
                                            color: titleTextColor,
                                          ),

                                          const SizedBox(width: 5),

                                          Text(
                                              '9785507650',
                                            style: subTextTextStyle,
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 15,
                                            color: titleTextColor,
                                          ),

                                          const SizedBox(width: 5),
                                          Text(
                                            '29-03-2024',
                                            style: subTextTextStyle,
                                          ),

                                          const SizedBox(width: 15),

                                          const Icon(
                                            CupertinoIcons.arrow_down_left,
                                            size: 15,
                                            color: titleTextColor,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                              'Contact Us',
                                            style: subTextTextStyle,
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.message_outlined,
                                            size: 15,
                                            color: titleTextColor,
                                          ),

                                          const SizedBox(width: 5),
                                          Text(
                                            'Message',
                                            style: subTextTextStyle,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      VerticalDivider(
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),

                                      const Icon(
                                          Icons.download_outlined,
                                        color: titleTextColor,
                                      ),
                                      const SizedBox(width: 8),

                                      const Icon(
                                          Icons.delete_outline_outlined,
                                        color: titleTextColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),

                        const SizedBox(height: 7),
                      ],
                    ),
                ),

              ],
            ),
          ),
        )
    );
  }

  Widget noEnquiryWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Center(
        child: Text(
          'Please "Generate Script" and add it to your website forms to fetch leads.'
              'You may need help from your web developer',
          textAlign: TextAlign.center,
          style: messageTextStyle,
        ),
      ),
    );
  }
}
