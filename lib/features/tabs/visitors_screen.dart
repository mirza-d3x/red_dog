import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/visitor_info_tile_model.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';
import '../../styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        mainAxisExtent: 132
                      ),
                      itemCount: tilesList.length,
                      itemBuilder: (BuildContext context,index) => tiles(context,tilesList[index].title, tilesList[index].value)
                  ),

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
                  // How are your visitor trending over time?
                  Text(
                    'How are your visitor trending over time?',
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
                                top: 24,
                                bottom: 12,
                              ),
                              child: LineChart(
                                showAvg ? avgData() : mainData(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 34,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showAvg = !showAvg;
                                });
                              },
                              child: Text(
                                'avg',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),

                  const SizedBox(height: 15),
                  // How well you retained the visitors?
                  Text(
                    'How well you retained the visitors?',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: whiteColor,
                            width: 300,
                            height: 250,
                            child: SfCircularChart(
                              palette: const <Color>[
                                newVisitorIndicatorColor,
                                returningVisitorIndicatorColor,
                              ],
                              series: <CircularSeries>[
                                DoughnutSeries<VisitorData,String>(
                                  dataSource: _chartData,
                                  xValueMapper: (VisitorData data,_) => data.type,
                                  yValueMapper: (VisitorData data,_) => data.value,
                                ),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: newVisitorIndicatorColor
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'New Visitor',
                                style: graphHintTextStyle,
                              ),

                              const SizedBox(width: 10),
                              Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: returningVisitorIndicatorColor
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                  'Returning Visitor',
                                style: graphHintTextStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // Where are your users from?

                  Text(
                    'Where are your users from?',
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
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 10),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Country',
                                    style: tableTitleTextStyle,
                                  ),
                                ),

                                Text(
                                  'Users',
                                  style: tableTitleTextStyle,
                                ),

                                Text(
                                  '% Users',
                                  style: tableTitleTextStyle,
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
                                padding: const EdgeInsets.only(right: 5,left: 10),
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
                                              Text(
                                                '${index + 1}',
                                                style: tableContentTextStyle,
                                              ),

                                              Text(
                                                'India',
                                                style: tableContentTextStyle,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 15),
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
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // What language do they speak?
                  Text(
                    'What language do they speak?',
                    style: normalTextStyle,
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
                                const SizedBox(width: 10),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Language',
                                    style: tableTitleTextStyle,
                                  ),
                                ),

                                Text(
                                  'Users',
                                  style: tableTitleTextStyle,
                                ),

                                Text(
                                  '% Users',
                                  style: tableTitleTextStyle,
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
                                padding: const EdgeInsets.only(right: 5,left: 10),
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
                                              Text(
                                                '${index + 1}',
                                                style: tableContentTextStyle,
                                              ),

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
                  Text(
                    'What is their age group?',
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
                      child: buildBarChart(),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // What is their gender?
                  Text(
                    'What is their gender?',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            color: whiteColor,
                            width: 300,
                            height: 250,
                            child: SfCircularChart(
                              palette: const <Color>[
                                maleIndicatorColor,
                                femaleIndicatorColor,
                              ],
                              series: <CircularSeries>[
                                DoughnutSeries<GenderData,String>(
                                  dataSource: _genderChartData,
                                  xValueMapper: (GenderData data,_) => data.type,
                                  yValueMapper: (GenderData data,_) => data.value,
                                ),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: maleIndicatorColor
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Male',
                                style: graphHintTextStyle,
                              ),

                              const SizedBox(width: 10),
                              Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: femaleIndicatorColor
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Female',
                                style: graphHintTextStyle,
                              )
                            ],
                          ),
                        ],
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

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        // border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBarChart() {
    List<charts.Series<BarChartData, String>> series = [
      charts.Series(
        id: '',
        data: data,
        domainFn: (BarChartData sales, _) => sales.category,
        measureFn: (BarChartData sales, _) => sales.value,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(barGraphColor),
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

