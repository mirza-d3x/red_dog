import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';
import '../../styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';

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

  @override
  void initState(){
    _chartData = getChartData();
    _genderChartData = getGenderChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  tiles('VISITORS', '140'),

                  const SizedBox(height: 8),
                  tiles('NEW VISITORS', '132'),

                  const SizedBox(height: 8),
                  tiles('BOUNCE RATE', '61.75%'),

                  const SizedBox(height: 8),
                  tiles('SESSIONS', '183'),

                  const SizedBox(height: 8),
                  tiles('AVG SESSION DURATION', '106.46 S'),

                  const SizedBox(height: 15),
                  // How are your visitor trending over time?
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
                          Text(
                            'How are your visitor trending over time?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // How well you retained the visitors?
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
                          Text(
                            'How well you retained the visitors?',
                            style: normalTextStyle,
                          ),

                          // const SizedBox(height: 8),
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

                  const SizedBox(height: 8),
                  // Where are your users from?
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
                          Text(
                            'Where are your users from?',
                            style: normalTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // What language do they speak?
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
                          Text(
                            'What language do they speak?',
                            style: normalTextStyle,
                          ),

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

                  const SizedBox(height: 8),
                  // What is their age group?
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
                          Text(
                            'What is their age group?',
                            style: normalTextStyle,
                          ),
                          buildBarChart()
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // What is their gender?
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
                          Text(
                            'What is their gender?',
                            style: normalTextStyle,
                          ),

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

