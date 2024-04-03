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

  TextEditingController searchKeywordController = TextEditingController();

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  dynamic selectedValue;
  bool isSortSelected = false;
  dynamic sortOrder;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lead Details',
                      style: normalTextStyle,
                    ),

                    Row(
                      children: [
                        Card(
                          elevation: 2,
                          child: InkWell(
                            onTap: (){
                              searchModal(context);
                            },
                            child: Container(
                                height: 43,
                                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.search_outlined,
                                  color: blackColor,
                                  size: 22,
                                )
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        Card(
                          child: Container(
                            height: 43,
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Stack(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: selectedValue == null
                                        ? Text(
                                      'Filter',
                                      style: filterTextStyle,
                                    )
                                        : Text(
                                      selectedValue,
                                      style: filterTextStyle,
                                    ),
                                    value: selectedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isSortSelected = true;
                                        selectedValue = newValue;
                                        selectedValue == 'A to Z' ? sortOrder = 'AtoZ' : sortOrder = 'ZtoA';
                                      });
                                    },
                                    items: [
                                      'A to Z',
                                      'Z to A'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                          style: filterTextStyle,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        // Card(
                        //   elevation: 2,
                        //   child: Container(
                        //       height: 43,
                        //       padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        //       decoration: BoxDecoration(
                        //         color: whiteColor,
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: const Icon(
                        //         Icons.filter_alt_outlined,
                        //         color: blackColor,
                        //         size: 22,
                        //       )
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Card(
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: highlightingColor,
                      boxShadow: [
                        BoxShadow(
                          color: highlightingColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 90,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Akshay M',
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
                              'akshay@gmail.com',
                              style: subTextTextStyle,
                            )
                          ],
                        ),

                        // const SizedBox(height: 5),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.phone_enabled,
                        //       size: 15,
                        //       color: titleTextColor,
                        //     ),
                        //
                        //     const SizedBox(width: 5),
                        //
                        //     Text(
                        //         '9785507650',
                        //       style: subTextTextStyle,
                        //     )
                        //   ],
                        // ),
                        //
                        // const SizedBox(height: 5),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.calendar_month,
                        //       size: 15,
                        //       color: titleTextColor,
                        //     ),
                        //
                        //     const SizedBox(width: 5),
                        //     Text(
                        //       '29-03-2024',
                        //       style: subTextTextStyle,
                        //     ),
                        //
                        //     const SizedBox(width: 15),
                        //
                        //     const Icon(
                        //       CupertinoIcons.arrow_down_left,
                        //       size: 15,
                        //       color: titleTextColor,
                        //     ),
                        //     const SizedBox(width: 3),
                        //     Text(
                        //         'Contact Us',
                        //       style: subTextTextStyle,
                        //     ),
                        //   ],
                        // ),
                        //
                        // const SizedBox(height: 5),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.message_outlined,
                        //       size: 15,
                        //       color: titleTextColor,
                        //     ),
                        //
                        //     const SizedBox(width: 5),
                        //     Text(
                        //       'Message',
                        //       style: subTextTextStyle,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
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
                              child: Column(
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

                                  // const SizedBox(height: 5),
                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.phone_enabled,
                                  //       size: 15,
                                  //       color: titleTextColor,
                                  //     ),
                                  //
                                  //     const SizedBox(width: 5),
                                  //
                                  //     Text(
                                  //         '9785507650',
                                  //       style: subTextTextStyle,
                                  //     )
                                  //   ],
                                  // ),
                                  //
                                  // const SizedBox(height: 5),
                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.calendar_month,
                                  //       size: 15,
                                  //       color: titleTextColor,
                                  //     ),
                                  //
                                  //     const SizedBox(width: 5),
                                  //     Text(
                                  //       '29-03-2024',
                                  //       style: subTextTextStyle,
                                  //     ),
                                  //
                                  //     const SizedBox(width: 15),
                                  //
                                  //     const Icon(
                                  //       CupertinoIcons.arrow_down_left,
                                  //       size: 15,
                                  //       color: titleTextColor,
                                  //     ),
                                  //     const SizedBox(width: 3),
                                  //     Text(
                                  //         'Contact Us',
                                  //       style: subTextTextStyle,
                                  //     ),
                                  //   ],
                                  // ),
                                  //
                                  // const SizedBox(height: 5),
                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.message_outlined,
                                  //       size: 15,
                                  //       color: titleTextColor,
                                  //     ),
                                  //
                                  //     const SizedBox(width: 5),
                                  //     Text(
                                  //       'Message',
                                  //       style: subTextTextStyle,
                                  //     )
                                  //   ],
                                  // ),
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

  void searchModal(BuildContext context){
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(5.0)),
      ),
        context: context,
        builder: (context){
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  cursorColor: blackColor,
                  cursorHeight: 21,
                  controller: searchKeywordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 4,left: 10),
                    hintText: 'Search for your data',
                    // hintStyle: searchTextStyle,
                    filled: true,
                    fillColor: whiteColor,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        if (searchKeywordController.text.isEmpty) {
                          Dialog(
                            child: Container(
                              height: 305,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                          final snackBar = SnackBar(
                            backgroundColor: loginBgColor,
                            content: Container(
                              height: 30,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Please enter a keyword to search',
                                    style:
                                    TextStyle(color: blackColor),
                                  )),
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             SearchProductList(searchKeywordController.text)
                          //     ));
                        }
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: buildTextFormColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: boxColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        },
    );
  }
}
