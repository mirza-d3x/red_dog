import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/features/common/notification_list_screen.dart';
import 'package:reddog_mobile_app/models/user_by_gender_model.dart';
import 'package:reddog_mobile_app/models/visitor_info_tile_model.dart';
import 'package:reddog_mobile_app/providers/registered_website_provider.dart';
import 'package:reddog_mobile_app/providers/user_profile_provider.dart';
import 'package:reddog_mobile_app/providers/visitor_provider.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import 'package:reddog_mobile_app/repositories/user_repository.dart';
import 'package:reddog_mobile_app/repositories/visitor_repository.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';
import 'package:reddog_mobile_app/widgets/tiles_full_width.dart';
import '../../core/ui_state.dart';
import '../../models/user_by_age_group_model.dart';
import '../../models/visitor_trending_time_model.dart';
import '../../styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../utilities/shared_prefernces.dart';
import 'package:reddog_mobile_app/models/user_by_newturned_model.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {

  UserProfileProvider userProfileProvider = UserProfileProvider(userRepository: UserRepository());

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());

  VisitorProvider visitorProvider = VisitorProvider(visitorRepository: VisitorRepository());

  getVisitorTileMethod() async{
      await visitorProvider.getVisitorTileData(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByTrendingTimeMethod() async{
    await visitorProvider.getUserByTrendingTimeList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  String storedWebsiteId = '';

  void getStoredWebsiteId() async{
    storedWebsiteId = await getValue('websiteId');
  }

  // visitors trending time graph color declarations
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  void initState(){
    super.initState();
    getStoredWebsiteId();
    deleteValue('websiteId');
    userProfileProvider.getProfile();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    getVisitorTileMethod();
    getUserByTrendingTimeMethod();
  }

  // drop down menu variables
  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;
  dynamic websiteName ;
  dynamic websiteViewId ;

  // Calender widget variables
  // Format the current date in "yyyy-MM-dd" format - todate
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());


  //initial from date
  String formattedInitialdDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 30)));

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
        getVisitorTileMethod();
        getUserByTrendingTimeMethod();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              elevation: 1,
              // scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
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

                        profileWidget(),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: bgColor,
          body: SingleChildScrollView(
              child: visitorsUiBasedOnAnalytics()
          ),
        )
    );
  }

  Widget profileWidget(){
    return ChangeNotifierProvider<UserProfileProvider>(
      create: (ctx){
        return userProfileProvider;
      },
      child: Column(
        children: [
          Consumer<UserProfileProvider>(builder: (ctx, data, _){
            var state = data.profileLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox();
            } else if (state is Success) {
              return PopupMenuButton(
                  constraints: const BoxConstraints.expand(width: 140,height: 70),
                  // padding: EdgeInsets.zero,
                  position: PopupMenuPosition.under,
                  child:
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: dividerColor,
                    backgroundImage:
                    NetworkImage('${data.profileModel.userDetails!.picture}'),
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
                            deleteValue('token');
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            });
                            // UpdateAddress(data.list[index]);
                          },
                          ),
                        ),height: 31,),
                    ];
                  }
              );
            }else if (state is Failure) {
              return CircleAvatar(
                radius: 20,
                backgroundColor: dividerColor,
                child: Icon(Icons.person_2_outlined,color: blackColor,),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  Widget visitorsUiBasedOnAnalytics(){
    return ChangeNotifierProvider<UserProfileProvider>(
      create: (ctx){
        return userProfileProvider;
      },
      child: Consumer<UserProfileProvider>(builder: (ctx, data, _){
        var state = data.profileLiveData().getValue();
        print(state);
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Center(
              child: CircularProgressIndicator(
                color: loginBgColor,
              ),
            ),
          );
        }else if (state is Success) {
          return data.profileModel.userDetails!.isAnalytics == false ?
          SizedBox(
              height: MediaQuery.of(context).size.height / 1.35,
              child: withoutAnalyticsWidget()
          ) :
          withAnalytics();
        }else if (state is Failure) {
          return Center(
            child: Text(
                'Failed to load!!!'
            ),
          );
        }else {
          return Container();
        }
      }),
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

  Widget withAnalytics(){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          websiteDropdownMenu(),

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
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                      Center(
                        child: Text(
                          _selectedFromDate != null && _selectedToDate != null ?
                          '${DateFormat('yyyy-MM-dd').format(_selectedFromDate) } to ${DateFormat('yyyy-MM-dd').format(_selectedToDate)}'
                              : '${formattedInitialdDate} to ${formattedDate}',
                          style: dropDownTextStyle,
                        ),
                      ),
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
          visitorApiDataWidget(),
        ],
      ),
    );
  }

  Widget websiteDropdownMenu(){
    return ChangeNotifierProvider<RegisteredWebsiteProvider>(
      create: (ctx){
        return registeredWebsiteProvider;
      },
      child: Consumer<RegisteredWebsiteProvider>(builder: (ctx, data, _){
        var state = data.websiteListLiveData().getValue();
        print(state);
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: CircularProgressIndicator(
                color: loginBgColor,
              ),
            ),
          );
        } else if (state is Success) {
          return Row(
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
                        hint: selectedWebsite == null
                            ? Row(
                          children: [
                            Text(
                                data.websiteListModel.data![0].name,
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
                          items:
                          data.websiteListModel.data!.map((e) {
                            websiteName = e.name;
                            websiteViewId = e.datumId;
                            return DropdownMenuItem(
                              // value: valueItem,
                              child: Text(e.name),
                              value: e.datumId,
                            );
                          },
                          ).toList(),
                          value: selectedWebsite,
                          onChanged: (val) {
                            deleteValue('websiteId');
                            deleteValue('websiteName');
                            setState(()  {
                              deleteValue('websiteId');
                              selectedWebsite = val;
                              setValue('websiteId', val);
                              getVisitorTileMethod();
                              // getUserByTrendingTimeMethod();
                            });
                          })

                      ),
                    ),
                  ),
                ),
            ],
          );
        }else if (state is Failure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text(''),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget visitorApiDataWidget(){
    return ChangeNotifierProvider<VisitorProvider>(
      create: (ctx){
        return visitorProvider;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        // Visitor Tile Data
          Consumer<VisitorProvider>(builder: (ctx, data, _){
            var state = data.visitorTileLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: CircularProgressIndicator(
                    color: loginBgColor,
                  ),
                ),
              );
            } else if (state is Success) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tiles(context,'VISITORS',
                        '${data.tileDataModel.data!.visitors}',
                      ),
                      tiles(context,'NEW VISITORS',
                          '${data.tileDataModel.data!.newVisitors}'
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tiles(context,'BOUNCE RATE',
                        '${data.tileDataModel.data!.bounceRate}',
                      ),
                      tiles(context,'SESSIONS', '${data.tileDataModel.data!.sessions}'),
                    ],
                  ),

                  const SizedBox(height: 8),
                  tilesFullWidth(context, 'AVG SESSION DURATION', '${data.tileDataModel.data!.avgSessionDuration} S'),
                ],
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    'Failed to load!!',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 15),
        // Visitor trending time graph
          Text(
            'Visitors trending time?',
            style: normalTextStyle,
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
                child:
                Stack(
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
                        child: trendingTimeGraphWidget(),
                        // LineChart(
                        //   mainData(),
                        // ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget trendingTimeGraphWidget(){
    return ChangeNotifierProvider<VisitorProvider>(
      create: (ctx) {
        return visitorProvider;
      },
      child: Consumer<VisitorProvider>(
        builder: (ctx, data, _) {
          var state = data.userByVisitorsTrendingTimeLiveData().getValue();
          print(state);
          if (state is IsLoading) {
            return SizedBox();
          }else if (state is Success) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 500,
                child: LineChart(
                    mainData(
                        data.userByVisitorsTrendingTimeModel.data ?? []
                      // data.userByVisitorsTrendingTimeModel.data!.length,
                      // data.userByVisitorsTrendingTimeModel.data!.length,
                    )
                ),
              ),
            );
          }else if (state is Failure) {
            return Text('Failed to load!!');
          }else {
            return SizedBox();
          }
        },
      ),
    );
  }

  LineChartData mainData(List<TrendingTimeData> data) {
    List<FlSpot> spots = [];
    double maxYValue = 0;
    // Determine the length of your date data list
    int dataLength = data.length;


    // Create FlSpot instances from your data
    for (int i = 0; i < data.length; i++) {
      double yValue = double.parse(data[i].value ?? '0');
      spots.add(FlSpot(i.toDouble(), double.parse(data[i].value ?? '0')));

      // Update maxYValue if current Y-value is greater
      if (yValue > maxYValue) {
        maxYValue = yValue;
      }
    }

    // Adjust maxYValue if needed (e.g., add some buffer)
    maxYValue += 2; // Adding buffer for better visualization

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 3,
        verticalInterval: 3,
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
            reservedSize: 35,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 3,
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
      maxX: dataLength.toDouble(),
      minY: 0,
      maxY: maxYValue,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          // spots: [
          //   FlSpot(1, 3),
          //   FlSpot(2, 5),
          //   FlSpot(3, 2),
          //   FlSpot(4, 10),
          //   FlSpot(5, 4),
          //   FlSpot(6, 4),
          //   FlSpot(7, 3),
          //   FlSpot(8, 4),
          // ],
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return ChangeNotifierProvider<VisitorProvider>(
      create: (ctx) {
        return visitorProvider;
      },
      child: Consumer<VisitorProvider>(
        builder: (ctx, data, _) {
          var state = data.userByVisitorsTrendingTimeLiveData().getValue();
          print(state);
          if (state is IsLoading) {
            return SizedBox();
          }else if (state is Success) {
            const style = TextStyle(
                fontSize: 12,
                fontFamily: 'Barlow-Regular',
                color: titleTextColor
            );

            // Find the corresponding date from dataList based on value
            final int index = value.toInt();
            if (index < 0 || index >= data.userByVisitorsTrendingTimeModel.data!.length) {
              return Container(); // Return an empty container if index is out of bounds
            }

            final String date = data.userByVisitorsTrendingTimeModel.data![index].date ?? ''; // Get date from dataList

            final text = Text(date, style: style);

            return Padding(
              padding: const EdgeInsets.only(right: 25,top: 5),
              child: SideTitleWidget(
                axisSide: meta.axisSide,
                child: text,
                angle: -math.pi / 3.5,
              ),
            );
          }else if (state is Failure) {
            return Text('Failed to load!!');
          }else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return ChangeNotifierProvider<VisitorProvider>(
      create: (ctx) {
        return visitorProvider;
      },
      child: Consumer<VisitorProvider>(
        builder: (ctx, data, _) {
          var state = data.userByVisitorsTrendingTimeLiveData().getValue();
          print(state);
          if (state is IsLoading) {
            return SizedBox();
          }else if (state is Success) {
            const style = TextStyle(
                fontSize: 12,
                fontFamily: 'Barlow-Regular',
                color: titleTextColor
            );

            // Find the corresponding date from dataList based on value
            int startValue = 0;
            int interval = 1;
            int index = value.toInt();
            // Adjust the maximum value
            int maxDisplayedValue = 13;
            if (index < 0 || index >= maxDisplayedValue) {
              return Container(); // Return an empty container if index is out of bounds
            }

            // if (index < 0 || index >= data.userByVisitorsTrendingTimeModel.data!.length) {
            //   return Container(); // Return an empty container if index is out of bounds
            // }

            // final text = (startValue + index * interval).toString();
            final String date = (startValue + index * interval).toString();
            //
            final text = Text(
                date,
                softWrap: false,
                maxLines: 1,
                style: style
            );

            return Padding(
              padding: const EdgeInsets.only(right: 20,top: 5),
              child: SideTitleWidget(
                axisSide: meta.axisSide,
                child: text,
                angle: 0,
              ),
            );
          }else if (state is Failure) {
            return Text('Failed to load!!');
          }else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
