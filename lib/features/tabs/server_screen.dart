import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/tiles.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

  List<Color> gradientColors = [
    lightRedColor,
    darkRedColor,
  ];

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tiles(context,'Average page load time', '6.03 ms'),
                    tiles(context,'Average server response time', '0.47 ms'),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tiles(context,'Average server latency', '6.03 ms'),
                    Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Content',
                                  style: tileTitleTextStyle,
                                ),
                                Text(
                                  'load time',
                                  style: tileTitleTextStyle,
                                )
                              ],
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '0.47 ms',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    )
                    // tiles(context,'Content load time', '0.47 ms'),
                  ],
                ),

                const SizedBox(height: 8),

                Card(
                  elevation: 2,
                  shadowColor: whiteColor,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uptime',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '67.65%',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),

                        Image.asset(
                          'assets/images/server_uptime.PNG',
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                Text(
                  'What is the average time to connect with your server (per day)?',
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
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        )
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
        text = '1000';
        break;
      case 6:
        text = '2000';
        break;
      case 9:
        text = '3000';
        break;
      case 12:
        text = '4000';
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
      maxX: 8,
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
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
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
}
