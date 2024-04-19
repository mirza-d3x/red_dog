import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../core/ui_state.dart';
import '../models/visitor_trending_time_model.dart';
import '../providers/registered_website_provider.dart';
import '../providers/visitor_provider.dart';
import '../repositories/common_repository.dart';
import '../repositories/visitor_repository.dart';
import '../styles/colors.dart';
import '../utilities/shared_prefernces.dart';

class ExampleClGraph extends StatefulWidget {
  const ExampleClGraph({super.key});

  @override
  State<ExampleClGraph> createState() => _ExampleClGraphState();
}

class _ExampleClGraphState extends State<ExampleClGraph> {

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());

  VisitorProvider visitorProvider = VisitorProvider(visitorRepository: VisitorRepository());

  @override
  void initState(){
    deleteValue('websiteId');
    registeredWebsiteProvider.getRegisteredWebsiteList();
    visitorProvider.getUserByTrendingTimeList(
      '2024-03-21',
        '2024-04-19'
        // _selectedFromDate != null ?
        // '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        // _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Card(
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
          ),
        )
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

  dynamic biggestVal;


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
            int maxDisplayedValue = 210;
            if (index < 0 || index > maxDisplayedValue) {
              return Container(); // Return an empty container if index is out of bounds
            }

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
        biggestVal = yValue;
      }
    }

    print('#############################%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    print(maxYValue);
    print(biggestVal);
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
            interval: 40,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 48,
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
      maxY: 160,
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
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
}
