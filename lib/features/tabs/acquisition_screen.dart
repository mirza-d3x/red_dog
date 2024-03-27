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

  dynamic trafficTimeDropDown;
  bool isSelectedTrafficTime = false;

  late List<WebsiteVisitData> _chartData;

  List<WebsiteVisitData> getChartData(){
    final List<WebsiteVisitData> chartData = [
      WebsiteVisitData('Unknown Source', 1000),
      WebsiteVisitData('Organic', 200),
      WebsiteVisitData('Referral', 300),
    ];
    return chartData;
  }

  final List<ChartData> chartData = [
    ChartData('01 Mar', 12, 35, 40),
    ChartData('02 Mar', 14, 11, 18),
    ChartData('03 Mar', 16, 50, 50),
    ChartData('04 Mar', 18, 16, 18),
    ChartData('06 Mar', 18, 16, 18),
    ChartData('07 Mar', 18, 16, 18)
  ];

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
                              // animationDelay: 0,
                              // animationDuration: 0,
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

                const SizedBox(height: 10),
                Card(
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                labelStyle: graphIndexTextStyle
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: graphIndexTextStyle,
                              majorGridLines: const MajorGridLines(width: 0),
                              visibleMinimum: 0, // Set the minimum visible value
                              visibleMaximum: 149, // Set the maximum visible value
                              interval: 30, // Set the interval here
                            ),
                            series: <CartesianSeries>[
                              StackedColumnSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y1,
                                  width: 0.4,
                                  color: referralBarColor
                              ),
                              StackedColumnSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y2,
                                  width: 0.4,
                                  color: unknownBarColor
                              ),
                              StackedColumnSeries<ChartData,String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y3,
                                  width: 0.4,
                                  color: organicBarColor
                              ),
                            ]
                        ),

                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: organicBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Organic',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),

                              const SizedBox(width: 20),

                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: unknownBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Unknown',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),

                              const SizedBox(width: 20),

                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: referralBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Referral',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What are the traffic sources?',
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
                            hint: trafficTimeDropDown == null
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
                                    trafficTimeDropDown,
                                    style: durationDropDownTextStyle
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            value: trafficTimeDropDown,
                            onChanged: (newValue) {
                              setState(() {
                                isSelectedTrafficTime = true;
                                trafficTimeDropDown = newValue;
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

class ChartData{
  ChartData(this.x, this.y1, this.y2, this.y3);
  final String x;
  final double y1;
  final double y2;
  final double y3;
}

