import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/features/common/notification_list_screen.dart';
import 'package:reddog_mobile_app/models/visitor_info_tile_model.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';
import 'package:reddog_mobile_app/widgets/tiles_full_width.dart';
import '../../styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class VisitorsScreen extends StatefulWidget {
  bool withAnalytics;
   VisitorsScreen(
      this.withAnalytics,
      {super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {

  late List<VisitorData> _chartData;
  late List<GenderData> _genderChartData;

  List<VisitorData> getChartData(){
    final List<VisitorData> chartData = [
      VisitorData('New Visitor', 1000),
      VisitorData('Returning Visitor', 200),
    ];
    return chartData;
  }

  List<GenderData> getGenderChartData(){
    final List<GenderData> genderChartData = [
      GenderData('Male', 1000),
      GenderData('Female', 700),
    ];
    return genderChartData;
  }

  final List<BarChartData> data = [
    BarChartData('18-24', 16),
    BarChartData('25-34', 17),
    BarChartData('35-44', 9),
  ];

 final tilesList = <VisitorTileModel>[];

  @override
  void initState(){
    _chartData = getChartData();
    _genderChartData = getGenderChartData();
    super.initState();
    tilesList.add(VisitorTileModel('VISITORS', '140'));
    tilesList.add(VisitorTileModel('NEW VISITORS', '132'));
    tilesList.add(VisitorTileModel('BOUNCE RATE', '61.75%'));
    tilesList.add(VisitorTileModel('SESSIONS', '183'));
    tilesList.add(VisitorTileModel('AVG SESSION DURATION', '106.46 S'));
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;
  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

  dynamic visitorTimeDropDown;
  bool isSelectedVisitor = false;

  dynamic retainedVisitorDropDown;
  bool isSelectedRetainedVisitor = false;

  dynamic visitorsFromDropDown;
  bool isSelectedVisitorFrom = false;

  dynamic languagePeriodDropDown;
  bool isSelectedLanguage = false;

  dynamic agePeriodDropDown;
  bool isSelectedAge = false;

  dynamic genderPeriodDropDown;
  bool isSelectedGender = false;

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

  String selectedOption = 'Country';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              elevation: 1,
              // scrolledUnderElevation: 0,
              backgroundColor: whiteColor,
              flexibleSpace: Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Image.asset(
                          'assets/images/redDog_logo.png',
                        height: 30,
                      ),
                    ),

                     Row(
                      children: [

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationListScreen()));
                          },
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            size: 27,
                            color: titleTextColor,
                          ),
                        ),
                        const SizedBox(width: 8),

                        PopupMenuButton(
                            constraints: const BoxConstraints.expand(width: 140,height: 70),
                            // padding: EdgeInsets.zero,
                            position: PopupMenuPosition.under,
                          child: const CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(
                                  'assets/images/profile_pic_sample.jpeg'
                              )

                          ),
                            itemBuilder: (BuildContext context){
                              return <PopupMenuItem <String>>[
                                PopupMenuItem<String> (
                                  child: Center(
                                    child: TextButton(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.logout,
                                            color: blackColor,
                                            size: 20,
                                          ),

                                          const SizedBox(width: 12),
                                          Text('Logout',
                                              style: nameTextStyle
                                          ),
                                        ],
                                      ),onPressed: (){
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                      });
                                      // UpdateAddress(data.list[index]);
                                    },
                                    ),
                                  ),height: 31,),
                              ];
                            }
                        ),
                        // CircleAvatar(
                        //   radius: 26,
                        //   backgroundImage: AssetImage(
                        //     'assets/images/profile_pic_sample.jpeg'
                        //   )
                        //
                        // ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: bgColor,
          body:
              widget.withAnalytics == false ?
          withoutAnalyticsWidget() :
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
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
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: InkWell(
                        
                          onTap: () =>  _selectDateRange(context),
                          child: Card(
                            elevation: 2,
                            child: Container(
                              height: 43,
                              // padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        flex: 1,
                        child: Padding(
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
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // GridView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 4.0,
                  //       mainAxisSpacing: 4.0,
                  //       mainAxisExtent: 132
                  //     ),
                  //     itemCount: tilesList.length,
                  //     itemBuilder: (BuildContext context,index) => tiles(context,tilesList[index].title, tilesList[index].value)
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tiles(context,'VISITORS', '140'),
                      tiles(context,'NEW VISITORS', '132'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tiles(context,'BOUNCE RATE', '61.75%'),
                      tiles(context,'SESSIONS', '183'),
                    ],
                  ),

                  const SizedBox(height: 8),
                  tilesFullWidth(context, 'AVG SESSION DURATION', '106.46 S'),


                  // tiles('VISITORS', '140'),
                  //
                  // const SizedBox(height: 8),
                  // tiles('NEW VISITORS', '132'),
                  //
                  // const SizedBox(height: 8),
                  // tiles('BOUNCE RATE', '61.75%'),
                  //
                  // const SizedBox(height: 8),
                  // tiles('SESSIONS', '183'),
                  //
                  // const SizedBox(height: 8),
                  // tiles('AVG SESSION DURATION', '106.46 S'),

                  const SizedBox(height: 15),
                  // Visitors trending time?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Visitors trending time?',
                        style: normalTextStyle,
                      ),

                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: visitorTimeDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 visitorTimeDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: visitorTimeDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedVisitor = true;
                      //             visitorTimeDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                      child: Stack(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1.70,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 18,
                                left: 12,
                                top: 10,
                                bottom: 12,
                              ),
                              child: LineChart(
                                mainData(),
                                // showAvg ? avgData() : mainData(),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 60,
                          //   height: 34,
                          //   child: TextButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         showAvg = !showAvg;
                          //       });
                          //     },
                          //     child: Text(
                          //       'avg',
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ),
                  ),

                  const SizedBox(height: 15),
                  // Retained visitors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Retained visitors',
                        style: normalTextStyle,
                      ),

                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: retainedVisitorDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 retainedVisitorDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: retainedVisitorDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedRetainedVisitor = true;
                      //             retainedVisitorDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),

                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Container(
                        color: whiteColor,
                        width: 300,
                        height: 200,
                        child: Stack(
                          children: [
                            SfCircularChart(
                              centerY: '100',
                              centerX: '90',
                              margin: EdgeInsets.zero,
                              palette: const <Color>[
                                graphGreyColor,
                                graphBlackColor,
                              ],
                              legend: Legend(
                                position: LegendPosition.right,
                                isVisible: true,
                                isResponsive:true,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<VisitorData,String>(
                                  dataSource: _chartData,
                                  xValueMapper: (VisitorData data,_) => data.type,
                                  yValueMapper: (VisitorData data,_) => data.value,
                                  innerRadius: '90%',
                                  radius: '60%',
                                ),
                              ],
                            ),

                            Positioned(
                              left: 73,
                              top: 93,
                              child: Text(
                                '25.7%',
                                style: visitorGraphValueTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // Where are your users from?

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Visitors from?',
                        style: normalTextStyle,
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: visitorsFromDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 visitorsFromDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: visitorsFromDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedVisitorFrom = true;
                      //             visitorsFromDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),

                  const SizedBox(height: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15,top: 15),
                        child: SimpleMap(
                          instructions: SMapWorld.instructions,
                          defaultColor: Colors.grey,
                          colors: const SMapWorldColors(
                            uS: Colors.blue,   // This makes USA green
                            cN: Colors.red,   // This makes China green
                            iN: Colors.green,   // This makes Russia green
                          ).toMap(),
                          callback: (id, name, tapDetails) {
                            print(id);
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // country list
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      height: 400,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(right: 5,top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = 'Country';
                                    });
                                  },
                                  child: Text(
                                    'Country',
                                    style: TextStyle(
                                      fontFamily: 'Barlow-Medium',
                                      color: selectedOption == 'Country' ? redColor : blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = 'City';
                                    });
                                  },
                                  child: Text(
                                    'City',
                                    style: TextStyle(
                                      fontFamily: 'Barlow-Medium',
                                      color: selectedOption == 'City' ? redColor : blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          selectedOption == 'Country' ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Country',
                                  style: tableTitleTextStyle,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  'Users',
                                  style: tableTitleTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: Text(
                                  '%',
                                  style: tableTitleTextStyle,
                                ),
                              )
                            ],
                          ):
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'City',
                                  style: tableTitleTextStyle,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Users',
                                  style: tableTitleTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: Text(
                                  '%',
                                  style: tableTitleTextStyle,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 3),
                          const Divider(
                            color: dividerColor,
                          ),

                          const SizedBox(height: 3),

                          selectedOption == 'Country' ?
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: ListView.builder(
                                  itemCount: 20,
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context,index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //   '${index + 1}',
                                              //   style: tableContentTextStyle,
                                              // ),

                                              Text(
                                                'India',
                                                style: tableContentTextStyle,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Text(
                                                  '1051',
                                                  style: tableContentTextStyle,
                                                ),
                                              ),

                                              LinearPercentIndicator(
                                                width: 65.0,
                                                lineHeight: 14.0,
                                                percent: 0.8, //percent value must be between 0.0 and 1.0
                                                backgroundColor: whiteColor,
                                                progressColor: percentageIndicatorColor,
                                                center: Text(
                                                  '83.10%',
                                                  style: percentTextStyle,
                                                ),
                                              ),


                                              // Text(
                                              //   '83.10%',
                                              //   style: tableContentTextStyle,
                                              // )
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 3),
                                        const Divider(
                                          color: dividerColor,
                                        ),
                                        const SizedBox(height: 3),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ):
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: ListView.builder(
                                  itemCount: 20,
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context,index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //   '${index + 1}',
                                              //   style: tableContentTextStyle,
                                              // ),

                                              Text(
                                                'Kochi',
                                                style: tableContentTextStyle,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Text(
                                                  '1051',
                                                  style: tableContentTextStyle,
                                                ),
                                              ),

                                              LinearPercentIndicator(
                                                width: 65.0,
                                                lineHeight: 14.0,
                                                percent: 0.8, //percent value must be between 0.0 and 1.0
                                                backgroundColor: whiteColor,
                                                progressColor: percentageIndicatorColor,
                                                center: Text(
                                                  '83.10%',
                                                  style: percentTextStyle,
                                                ),
                                              ),


                                              // Text(
                                              //   '83.10%',
                                              //   style: tableContentTextStyle,
                                              // )
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 3),
                                        const Divider(
                                          color: dividerColor,
                                        ),
                                        const SizedBox(height: 3),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // What language do they speak?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What language do they speak?',
                        style: normalTextStyle,
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: languagePeriodDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 languagePeriodDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: languagePeriodDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedLanguage = true;
                      //             languagePeriodDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    shadowColor: whiteColor,
                    child: Container(
                      height: 400,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          const Divider(
                            color: dividerColor,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Language',
                                    style: tableTitleTextStyle,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Users',
                                    style: tableTitleTextStyle,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 35),
                                  child: Text(
                                    '%',
                                    style: tableTitleTextStyle,
                                  ),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 3),
                          const Divider(
                            color: dividerColor,
                          ),

                          const SizedBox(height: 3),

                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: ListView.builder(
                                  itemCount: 20,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context,index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //   '${index + 1}',
                                              //   style: tableContentTextStyle,
                                              // ),

                                              Text(
                                                'English',
                                                style: tableContentTextStyle,
                                              ),

                                              Text(
                                                '118',
                                                style: tableContentTextStyle,
                                              ),

                                              LinearPercentIndicator(
                                                width: 65.0,
                                                lineHeight: 14.0,
                                                percent: 0.8, //percent value must be between 0.0 and 1.0
                                                backgroundColor: whiteColor,
                                                progressColor: percentageIndicatorColor,
                                                center: Text(
                                                    '83.10%',
                                                  style: percentTextStyle,
                                                ),
                                              ),


                                              // Text(
                                              //   '83.10%',
                                              //   style: tableContentTextStyle,
                                              // )
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 3),
                                        const Divider(
                                          color: dividerColor,
                                        ),
                                        const SizedBox(height: 3),
                                      ],
                                    );
                                    },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // What is their age group?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What is their age group?',
                        style: normalTextStyle,
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: agePeriodDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 agePeriodDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: agePeriodDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedAge = true;
                      //             agePeriodDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 10),
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
                      child: buildBarChart(),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // What is their gender?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What is their gender?',
                        style: normalTextStyle,
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Container(
                      //     height: 30,
                      //     // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     padding: const EdgeInsets.only(left: 10,right: 10),
                      //     // margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                      //     decoration: BoxDecoration(
                      //       color: whiteColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton(
                      //         icon: const Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: blackColor,
                      //         ),
                      //         // iconSize: 0,
                      //         hint: genderPeriodDropDown == null
                      //             ? Row(
                      //           children: [
                      //             Text(
                      //                 'Weekly',
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //
                      //             const SizedBox(width: 5),
                      //           ],
                      //         )
                      //             : Row(
                      //           children: [
                      //             Text(
                      //                 genderPeriodDropDown,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //             const SizedBox(width: 5),
                      //           ],
                      //         ),
                      //         value: genderPeriodDropDown,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             isSelectedGender = true;
                      //             genderPeriodDropDown = newValue;
                      //           });
                      //         },
                      //         items: [
                      //           'Weekly',
                      //           'Monthly',
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value,
                      //                 style: durationDropDownTextStyle
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 10),
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
                      child: Container(
                        color: whiteColor,
                        width: 300,
                        height: 200,
                        child: Stack(
                          children: [
                            SfCircularChart(
                              centerY: '100',
                              centerX: '90',
                              margin: EdgeInsets.zero,
                              palette: const <Color>[
                                maleIndicatorColor,
                                femaleIndicatorColor,
                              ],
                              legend: Legend(
                                position: LegendPosition.right,
                                isVisible: true,
                                isResponsive:true,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<GenderData,String>(
                                  dataSource: _genderChartData,
                                  xValueMapper: (GenderData data,_) => data.type,
                                  yValueMapper: (GenderData data,_) => data.value,
                                  innerRadius: '90%',
                                  radius: '60%',
                                ),
                              ],
                            ),

                            Positioned(
                              left: 62,
                              top: 93,
                              child: Text(
                                '',
                                // 'Mar 2024',
                                style: graphValueTextStyle,
                              ),
                            )
                          ],
                        ),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontFamily: 'Barlow-Regular',
      color: titleTextColor
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Feb 26',
            style: style
        );
        break;
      case 1:
        text = const Text('Feb 27',
            style: style,
        );
        break;
      case 2:
        text = const Text('Feb 28',
            style: style
        );
        break;
      case 3:
        text = const Text('Feb 29',
            style: style
        );
        break;
      case 4:
        text = const Text('Mar 01',
            style: style
        );
        break;
      case 5:
        text = const Text('Mar 02',
            style: style
        );
        break;
      case 6:
        text = const Text('Mar 03',
            style: style
        );
        break;
      case 7:
        text = const Text('Mar 04',
            style: style
        );
        break;
      case 8:
        text = const Text('Mar 05',
            style: style
        );
        break;
      case 9:
        text = const Text('Mar 06',
            style: style
        );
        break;
      case 10:
        text = const Text('Mar 07',
            style: style
        );
        break;
      default:
        text = const Text('',
            style: style
        );
        break;
    }

    return
      Padding(
        padding: const EdgeInsets.only(right: 25,top: 5),
        child: SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
          angle: -math.pi / 3.5,
            ),
      );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 12,
        fontFamily: 'Barlow-Regular',
        color: titleTextColor
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 3:
        text = '4';
        break;
      case 6:
        text = '8';
        break;
      case 9:
        text = '12';
        break;
      case 12:
        text = '16';
        break;
      default:
        return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Text(text, style: style, textAlign: TextAlign.end),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 3,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: dividerColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false,),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 14,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 5),
            FlSpot(2.6, 2),
            FlSpot(4.9, 10),
            FlSpot(6.8, 4),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  // LineChartData avgData() {
  //   return LineChartData(
  //     lineTouchData: const LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawVerticalLine: false,
  //       drawHorizontalLine: true,
  //       verticalInterval: 1,
  //       horizontalInterval: 1,
  //       getDrawingVerticalLine: (value) {
  //         return const FlLine(
  //           color: Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingHorizontalLine: (value) {
  //         return const FlLine(
  //           color: Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           getTitlesWidget: bottomTitleWidgets,
  //           interval: 1,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 42,
  //           interval: 1,
  //         ),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //       // border: Border.all(color: const Color(0xff37434d)),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: const [
  //           FlSpot(0, 3.44),
  //           FlSpot(2.6, 3.44),
  //           FlSpot(4.9, 3.44),
  //           FlSpot(6.8, 3.44),
  //           FlSpot(8, 3.44),
  //           FlSpot(9.5, 3.44),
  //           FlSpot(11, 3.44),
  //         ],
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: [
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //           ],
  //         ),
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: const FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildBarChart() {
    List<charts.Series<BarChartData, String>> series = [
      charts.Series(
        id: '',
        data: data,
        domainFn: (BarChartData sales, _) => sales.category,
        measureFn: (BarChartData sales, _) => sales.value,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(graphBlackColor),
        // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (BarChartData sales, _) => '${sales.value}',
        insideLabelStyleAccessorFn: (BarChartData sales, _){
          return  const charts.TextStyleSpec(
            fontFamily: 'Barlow-Bold',
            color:  charts.MaterialPalette.white,
            fontSize: 16,
          );
        }
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 300.0,
        child: charts.BarChart(
          series,
          animate: true,
          barGroupingType: charts.BarGroupingType.grouped,

          // custom X- axis
          domainAxis: charts.OrdinalAxisSpec(
            // X-axis configuration
            renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontFamily: 'Barlow-Regular',
                  color: charts.ColorUtil.fromDartColor(barGraphLabelColor),
                  fontSize: 12
              ),
            ),
          ),

          // Customize Y-axis values
          primaryMeasureAxis: charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontFamily: 'Barlow-Regular',
                color: charts.ColorUtil.fromDartColor(barGraphLabelColor),
                fontSize: 12,
              ),
            ),
            tickProviderSpec: const charts.StaticNumericTickProviderSpec(
              // Custom ticks from 0 to 20 with an interval of 4
              <charts.TickSpec<num>>[
                charts.TickSpec<num>(0),
                charts.TickSpec<num>(4),
                charts.TickSpec<num>(8),
                charts.TickSpec<num>(12),
                charts.TickSpec<num>(16),
                charts.TickSpec<num>(20),
              ],
            ),
            tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                  (value) => '${value!.toInt()}',
            ),
          ),

          //  display values on bars

           barRendererDecorator: charts.BarLabelDecorator<String>(
        labelPosition: charts.BarLabelPosition.inside, // Position of the label
        labelAnchor: charts.BarLabelAnchor.middle, // Anchor point of the label
        labelPadding: 4, // Padding around the label
      ),
          // behaviors: [charts.SeriesLegend()],
        ),
      ),
    );
  }

}


class BarChartData {
  final String category;
  final int value;

  BarChartData(this.category, this.value);
}

class VisitorData{
  final String type;
  final int value;
  VisitorData(this.type,this.value);
}

class GenderData{
  final String type;
  final int value;
  GenderData(this.type,this.value);
}

