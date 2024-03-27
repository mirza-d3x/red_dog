import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../styles/text_styles.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  final List<ChartData> chartData = [
    ChartData('01 Mar', 12, 35, 40),
    ChartData('02 Mar', 14, 11, 18),
    ChartData('03 Mar', 16, 50, 50),
    ChartData('04 Mar', 18, 16, 18),
    ChartData('06 Mar', 18, 16, 18),
    ChartData('07 Mar', 18, 16, 18)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Container(
                height: 200,
                  child: SfCartesianChart(
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
                  )
              )
          )
      ),
    );
  }
}
class ChartData{
  ChartData(this.x, this.y1, this.y2, this.y3);
  final String x;
  final double y1;
  final double y2;
  final double y3;
}
