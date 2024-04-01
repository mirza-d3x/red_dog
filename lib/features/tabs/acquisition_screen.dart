import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/common_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../styles/text_styles.dart';

class AcquisitionScreen extends StatefulWidget {
  bool withAnalytics;
   AcquisitionScreen(this.withAnalytics,{super.key});

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

  late List<TrafficSourcePieChartData> _trafficChartData;

  List<TrafficSourcePieChartData> getTrafficChartData(){
    final List<TrafficSourcePieChartData> trafficChartData = [
      TrafficSourcePieChartData('Direct', 1000),
      TrafficSourcePieChartData('Google', 200),
      TrafficSourcePieChartData('Timejobs', 100),
      TrafficSourcePieChartData('m.timejobs', 70),
      TrafficSourcePieChartData('Clutch', 50),
      TrafficSourcePieChartData('Others', 30),
    ];
    return trafficChartData;
  }

  final List<ChartData> chartData = [
    ChartData('01 Mar', 22, 35, 10),
    ChartData('02 Mar', 14, 11, 18),
    ChartData('03 Mar', 16, 30, 50),
    ChartData('04 Mar', 18, 16, 18),
    ChartData('06 Mar', 18, 16, 18),
    ChartData('07 Mar', 18, 16, 18)
  ];

  dynamic mostVisitedOptionDropDown;
  bool isSelectedMostVisited = false;

  dynamic deviceTypeOptionDropDown;
  bool isSelectedDeviceType = false;


  late List<UsedDeviceData> _deviceChartData;

  List<UsedDeviceData> getDeviceChartData(){
    final List<UsedDeviceData> deviceChartData = [
      UsedDeviceData('Desktop', 1000),
      UsedDeviceData('Mobile', 200),
      UsedDeviceData('Tablet', 100),
    ];
    return deviceChartData;
  }

  @override
  void initState(){
    _chartData = getChartData();
    _trafficChartData = getTrafficChartData();
    _deviceChartData = getDeviceChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Acquisition'),
          backgroundColor: bgColor,
          body:
              widget.withAnalytics == false ?
                  withoutAnalyticsWidget():
          SingleChildScrollView(
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

                // How people found your website heading + drop down
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

                // Circular chart
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
                // Stacked column graph
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

                // what are the traffic sources heading + drop down menu
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

                const SizedBox(height: 10),
                // stacked Column graph
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
                                  color: directBarColor
                              ),
                              StackedColumnSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y2,
                                  width: 0.4,
                                  color: timeJobBarColor
                              ),
                              StackedColumnSeries<ChartData,String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y3,
                                  width: 0.4,
                                  color: googleBarColor
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
                                    color: directBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Direct',
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
                                    color: timeJobBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'TimeJobs',
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
                                    color: googleBarColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Google',
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
                // Circular chart
                Card(
                  elevation: 2,
                  child: Container(
                    // height: 340,
                    padding:  EdgeInsets.zero,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SfCircularChart(
                              margin: EdgeInsets.zero,
                              palette: const <Color>[
                                graphGreyColor,
                                googleIndicatorColor,
                                graphRedColor,
                                mTimeJobsIndicatorColor,
                                clutchIndicatorColor,
                                othersIndicatorColor
                              ],
                              series: <CircularSeries>[
                                DoughnutSeries<TrafficSourcePieChartData,String>(
                                  // animationDelay: 0,
                                  // animationDuration: 0,
                                  dataSource: _trafficChartData,
                                  xValueMapper: (TrafficSourcePieChartData data,_) => data.type,
                                  yValueMapper: (TrafficSourcePieChartData data,_) => data.value,
                                  innerRadius: '90%',
                                  radius: '60%',

                                ),
                              ],
                            ),

                            Positioned(
                              left: 148,
                              top: 140,
                              child: Text(
                                'Mar 2024',
                                style: graphValueTextStyle,
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 35,right: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: graphGreyColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Direct',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),

                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: graphRedColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'TimeJobs',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),

                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: mTimeJobsIndicatorColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'm.timeJobs',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 35,right: 35,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: googleIndicatorColor,
                                  ),

                                  const SizedBox(width: 5),
                                  Text(
                                    'Google',
                                    style: graphHintTextStyle,
                                  )
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: clutchIndicatorColor,
                                    ),

                                    const SizedBox(width: 5),
                                    Text(
                                      'Clutch',
                                      style: graphHintTextStyle,
                                    )
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: othersIndicatorColor,
                                    ),

                                    const SizedBox(width: 5),
                                    Text(
                                      'Others',
                                      style: graphHintTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                const SizedBox(height: 10),

                // what are the most visited pages heading + drop down menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What are the most visited pages?',
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
                            hint: mostVisitedOptionDropDown == null
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
                                    mostVisitedOptionDropDown,
                                    style: durationDropDownTextStyle
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            value: mostVisitedOptionDropDown,
                            onChanged: (newValue) {
                              setState(() {
                                isSelectedMostVisited = true;
                                mostVisitedOptionDropDown = newValue;
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

              // website list
                Card(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: whiteColor
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Page',
                              style: tableTitleTextStyle,
                            ),

                            Text(
                                'Users',
                              style: tableTitleTextStyle,
                            )
                          ],
                        ),

                        const SizedBox(height: 15),

                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            itemBuilder: (context,index) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Codelattice Leadership',
                                      style: tableContentTextStyle,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        '18',
                                        style: tableContentTextStyle,
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 15),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                // What are the devices used heading + drop down
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What are the devices used',
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
                            hint: deviceTypeOptionDropDown == null
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
                                    deviceTypeOptionDropDown,
                                    style: durationDropDownTextStyle
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            value: deviceTypeOptionDropDown,
                            onChanged: (newValue) {
                              setState(() {
                                isSelectedDeviceType = true;
                                deviceTypeOptionDropDown = newValue;
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

                // Circular chart
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
                            DoughnutSeries<UsedDeviceData,String>(
                              // animationDelay: 0,
                              // animationDuration: 0,
                              dataSource: _deviceChartData,
                              xValueMapper: (UsedDeviceData data,_) => data.type,
                              yValueMapper: (UsedDeviceData data,_) => data.value,
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

  Widget withoutAnalyticsWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Center(
        child: Text(
          'Kindly integrate your website with Google Analytics and sign up with '
              'RedDog to access the content of this page',
          textAlign: TextAlign.center,
          style: messageTextStyle,
        ),
      ),
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

class TrafficSourcePieChartData{
  final String type;
  final int value;
  TrafficSourcePieChartData(this.type,this.value);
}

class UsedDeviceData{
  final String type;
  final int value;
  UsedDeviceData(this.type,this.value);
}

