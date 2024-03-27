import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/common_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../styles/text_styles.dart';

class AcquisitionScreen extends StatefulWidget {
  const AcquisitionScreen({super.key});

  @override
  State<AcquisitionScreen> createState() => _AcquisitionScreenState();
}

class _AcquisitionScreenState extends State<AcquisitionScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

  dynamic peopleTimeDropDown;
  bool isSelectedPeopleFound = false;

  late List<WebsiteVisitData> _chartData;

  List<WebsiteVisitData> getChartData(){
    final List<WebsiteVisitData> chartData = [
      WebsiteVisitData('Unknown Source', 1000),
      WebsiteVisitData('Organic', 200),
      WebsiteVisitData('Referral', 300),
    ];
    return chartData;
  }

  @override
  void initState(){
    _chartData = getChartData();
    super.initState();
  }

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
                    Text(
                      'Visitors trending time?',
                      style: normalTextStyle,
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        height: 30,
                        // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
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
                            hint: peopleTimeDropDown == null
                                ? Row(
                              children: [
                                Text(
                                    'Monthly',
                                    style: durationDropDownTextStyle
                                ),

                                const SizedBox(width: 5),
                              ],
                            )
                                : Row(
                              children: [
                                Text(
                                    peopleTimeDropDown,
                                    style: durationDropDownTextStyle
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            value: peopleTimeDropDown,
                            onChanged: (newValue) {
                              setState(() {
                                isSelectedPeopleFound = true;
                                peopleTimeDropDown = newValue;
                              });
                            },
                            items: [
                              'Weekly',
                              'Monthly',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: durationDropDownTextStyle
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Card(
                  elevation: 2,
                  child: Container(
                    height: 200,
                    padding:  EdgeInsets.zero,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: whiteColor,
                    ),
                    child: Stack(
                      children: [
                        SfCircularChart(
                          centerY: '100',
                          centerX: '90',
                          margin: EdgeInsets.zero,
                          palette: const <Color>[
                            graphGreyColor,
                            graphBlackColor,
                            graphRedColor
                          ],
                          legend: Legend(
                            position: LegendPosition.right,
                            isVisible: true,
                            isResponsive:true,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                          series: <CircularSeries>[
                            DoughnutSeries<WebsiteVisitData,String>(
                              dataSource: _chartData,
                              xValueMapper: (WebsiteVisitData data,_) => data.type,
                              yValueMapper: (WebsiteVisitData data,_) => data.value,
                              innerRadius: '90%',
                              radius: '60%',

                            ),
                          ],
                        ),

                        Positioned(
                          left: 62,
                          top: 93,
                          child: Text(
                              'Mar 2024',
                            style: graphValueTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}

class WebsiteVisitData{
  final String type;
  final int value;
  WebsiteVisitData(this.type,this.value);
}

