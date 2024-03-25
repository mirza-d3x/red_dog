import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';
import '../../styles/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                          )
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
                          )
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

