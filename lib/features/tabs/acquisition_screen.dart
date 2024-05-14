import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:reddog_mobile_app/models/acquisition_top_channels_model.dart';
import 'package:reddog_mobile_app/models/device_category_model.dart';
import 'package:reddog_mobile_app/models/traffic_source_model.dart';
import 'package:reddog_mobile_app/providers/acquisition_provider.dart';
import 'package:reddog_mobile_app/repositories/acquisition_repository.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/common_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/ui_state.dart';
import '../../models/top_channels_by_date_model.dart';
import '../../models/traffic_source_by_date_model.dart';
import '../../providers/registered_website_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../repositories/common_repository.dart';
import '../../repositories/user_repository.dart';
import '../../styles/text_styles.dart';
import '../../utilities/shared_prefernces.dart';

class AcquisitionScreen extends StatefulWidget {
   AcquisitionScreen({super.key});

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

  final List<ChartData> chartData = [
    ChartData('01 Mar', 22, 35, 10),
    ChartData('02 Mar', 14, 11, 18),
    ChartData('03 Mar', 16, 30, 50),
    ChartData('04 Mar', 18, 16, 18),
    ChartData('06 Mar', 18, 16, 18),
    ChartData('07 Mar', 18, 16, 18),
    ChartData('08 Mar', 18, 16, 18),
    ChartData('09 Mar', 18, 16, 18),
    ChartData('10 Mar', 18, 16, 18),
    ChartData('11 Mar', 18, 16, 18),
    // ChartData('12 Mar', 18, 16, 18),
    // ChartData('13 Mar', 18, 16, 18),
    // ChartData('14 Mar', 18, 16, 18),
    // ChartData('15 Mar', 18, 16, 18),
  ];

  dynamic mostVisitedOptionDropDown;
  bool isSelectedMostVisited = false;

  dynamic deviceTypeOptionDropDown;
  bool isSelectedDeviceType = false;


  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());
  dynamic websiteName ;
  dynamic websiteViewId;

  //initial from date
  String formattedInitialdDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: 30)));

  UserProfileProvider userProfileProvider = UserProfileProvider(userRepository: UserRepository());

  AcquisitionProvider acquisitionProvider = AcquisitionProvider(acquisitionRepository: AcquisitionRepository());

  acquisitionApiCall() {
    // top channels
    acquisitionProvider.getTopChannels(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    // top channels by date
    acquisitionProvider.getTopChannelsByDate(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );


    // traffic source by date
    acquisitionProvider.getTrafficSourceByDate(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );


    // traffic source
    acquisitionProvider.getTrafficSource(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    // most visited page
    acquisitionProvider.getMostVisitedPageList(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

  // device category
    acquisitionProvider.getDeviceCategory(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    // search keyword list
    acquisitionProvider.getSearchKeywordList(
    _selectedFromDate != null
    ?
    '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
        : formattedInitialdDate,
    _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
    _selectedToDate)}' : formattedDate
    );
  }

  @override
  void initState(){
    userProfileProvider.getProfile();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    acquisitionApiCall();
    super.initState();
  }

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
        acquisitionApiCall();
      });
    }
  }

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Acquisition'),
          backgroundColor: bgColor,
          body:
          SingleChildScrollView(
              child: uiWidget(),
          ),
        )
    );
  }

  Widget uiWidget(){
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
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: Center(
                  child: CircularProgressIndicator(
                    color: loginBgColor,
                  ),
                ),
              );
            } else if (state is Success) {
              return data.profileModel.userDetails!.isAnalytics == false ?
              SizedBox(
                  height: MediaQuery.of(context).size.height / 1.35,
                  child: withoutAnalyticsWidget()
              ) :
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // drop dwn menu,calander,download button
                    websiteDropdownMenu(),

                    const SizedBox(height: 5),
                    InkWell(

                      onTap: () =>  _selectDateRange(context),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 43,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                _selectedFromDate != null && _selectedToDate != null ?
                                '${DateFormat('yyyy-MM-dd').format(_selectedFromDate) } to ${DateFormat('yyyy-MM-dd').format(_selectedToDate)}'
                                    : '${formattedInitialdDate} to ${formattedDate}',
                                style: dropDownTextStyle,
                              ),
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

                    const SizedBox(height: 10),

                    acquisitionApiDataWidget(),
                  ],
                ),
              );
            }else if (state is Failure) {
              return Text('');
            } else {
              return Container();
            }
          }),
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
                        // iconSize: 0,
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
                              acquisitionApiCall();
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
            height: MediaQuery.of(context).size.height / 1.4,
            child: Center(
              child:withoutAnalyticsWidget(),
            ),
          );
        } else {
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

  Widget acquisitionApiDataWidget(){
    return ChangeNotifierProvider<AcquisitionProvider>(
      create: (ctx){
        return acquisitionProvider;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.topChannelsLiveData().getValue();
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
                  Text(
                    'How did people find your website?',
                    style: normalTextStyle,
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
                              directIndicatorColor,
                              organicSearchIndicatorColor,
                              organicSocialIndicatorColor,
                              referralIndicatorColor,
                              organicVideoIndicatorColor,
                              unAssignedIndicatorColor
                            ],
                            legend: Legend(
                              position: LegendPosition.right,
                              isVisible: true,
                              isResponsive:true,
                              overflowMode: LegendItemOverflowMode.wrap,
                            ),
                            series: <CircularSeries>[
                              DoughnutSeries<TopChannelData,String>(
                                // animationDelay: 0,
                                // animationDuration: 0,
                                dataSource: data.topChannelsModel.data,
                                xValueMapper: (TopChannelData data,_) => data.key,
                                yValueMapper: (TopChannelData data,_) => int.parse(data.value),
                                innerRadius: '65%',
                                radius: '70%',

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    'Failed to load',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 10),
          // Stacked column graph - top channels by data
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.topChannelsByDateLiveData().getValue();
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
              int largestValue = findLargestValueAcrossLists(data.topChannelsByDateModel.data!);
              return Card(
                elevation: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: whiteColor,
                  ),
                  child:
                  Column(
                    children: [
                      SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              labelStyle: graphIndexTextStyle,
                            labelRotation: -80,
                            visibleMinimum: 0, // Set the minimum visible value
                            visibleMaximum: 30, // Set the maximum visible value
                            interval: 1,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: graphIndexTextStyle,
                            majorGridLines: const MajorGridLines(width: 0),
                            visibleMinimum: 0, // Set the minimum visible value
                            visibleMaximum:
                                largestValue <= 15 ? 15
                                : largestValue > 15 && largestValue <= 50 ?
                                50 :
                                largestValue > 50 && largestValue <= 200 ? 200
                            : largestValue > 200 && largestValue <= 1000 ?
                            1000 : 5000,// Set the maximum visible value
                            interval: largestValue <= 15 ? 3
                            : largestValue > 15 && largestValue <= 50 ? 10
                            : largestValue > 50 && largestValue <= 200
                            ? 50 : largestValue > 200 && largestValue <= 100 ?
                            250 : 1000,
                          ),
                          series: <CartesianSeries>[
                            // Direct
                            StackedColumnSeries<ChannelsByDateValues, String>(
                                dataSource: data.topChannelsByDateModel.data![0].data!,
                                xValueMapper: (ChannelsByDateValues data, _) => data.key,
                                yValueMapper: (ChannelsByDateValues data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                 color: directChannelColor
                            ),
                            // Organic Search
                            StackedColumnSeries<ChannelsByDateValues, String>(
                                dataSource: data.topChannelsByDateModel.data![1].data!,
                                xValueMapper: (ChannelsByDateValues data, _) => data.key,
                                yValueMapper: (ChannelsByDateValues data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: organicSearchChannelColor
                            ),
                            // Referral
                            StackedColumnSeries<ChannelsByDateValues,String>(
                                dataSource: data.topChannelsByDateModel.data![2].data!,
                                xValueMapper: (ChannelsByDateValues data, _) => data.key,
                                yValueMapper: (ChannelsByDateValues data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: referralChannelColor
                            ),
                            // Organic Social
                            StackedColumnSeries<ChannelsByDateValues,String>(
                                dataSource: data.topChannelsByDateModel.data![2].data!,
                                xValueMapper: (ChannelsByDateValues data, _) => data.key,
                                yValueMapper: (ChannelsByDateValues data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: organicSocialChannelColor
                            ),
                            // Unassigned
                            StackedColumnSeries<ChannelsByDateValues,String>(
                                dataSource: data.topChannelsByDateModel.data![2].data!,
                                xValueMapper: (ChannelsByDateValues data, _) => data.key,
                                yValueMapper: (ChannelsByDateValues data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: unassignedChannelColor
                            ),
                          ]
                      ),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 23,
                              crossAxisSpacing: 1,
                            ),
                            itemCount: 5,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index) => Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color:
                                  data.topChannelsByDateModel.data![index].name == "Direct"?
                                      directChannelColor :
                                  data.topChannelsByDateModel.data![index].name == "Organic Search"?
                                      organicSearchChannelColor :
                                  data.topChannelsByDateModel.data![index].name == "Organic Social"?
                                      organicSocialChannelColor :
                                  data.topChannelsByDateModel.data![index].name == "Referral"?
                                      referralChannelColor :
                                      unassignedChannelColor
                                ),

                                const SizedBox(width: 5),
                                Text(
                                  '${data.topChannelsByDateModel.data![index].name}',
                                  style: graphHintTextStyle,
                                )
                              ],
                            ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    'Failed to load',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 10),

          // what are the traffic sources heading
          Text(
            'What are the traffic sources?',
            style: normalTextStyle,
          ),
          const SizedBox(height: 10),

          const SizedBox(height: 10),
          // stacked Column graph traffic sources by date
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.trafficSourceByDateLiveData().getValue();
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
              int highestValue = findLargestValueAcrossTrafficSource(data.trafficSourceByDateModel.data!);
              return Card(
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
                              labelStyle: graphIndexTextStyle,
                              labelRotation: -80,
                            visibleMinimum: 0, // Set the minimum visible value
                            visibleMaximum: 30, // Set the maximum visible value
                            interval: 1,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: graphIndexTextStyle,
                            majorGridLines: const MajorGridLines(width: 0),
                            visibleMinimum: 0, // Set the minimum visible value
                            visibleMaximum: highestValue <= 15 ? 15
                                : highestValue > 15 && highestValue <= 50 ?
                            50 :
                            highestValue > 50 && highestValue <= 200 ? 200
                                : highestValue > 200 && highestValue <= 1000 ?
                            1000 : 5000,// Set the maximum visible value
                            interval: highestValue <= 15 ? 3
                                : highestValue > 15 && highestValue <= 50 ? 10
                                : highestValue > 50 && highestValue <= 200
                                ? 50 : highestValue > 200 && highestValue <= 100 ?
                            250 : 1000, // Set the interval here
                          ),
                          series: <CartesianSeries>[
                            StackedColumnSeries<TrafficDataByDate, String>(
                                dataSource: data.trafficSourceByDateModel.data![0].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: directBarColor
                            ),
                            StackedColumnSeries<TrafficDataByDate, String>(
                                dataSource: data.trafficSourceByDateModel.data![1].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: googleBarColor
                            ),
                            StackedColumnSeries<TrafficDataByDate,String>(
                                dataSource: data.trafficSourceByDateModel.data![2].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: bingBarColor
                            ),
                            StackedColumnSeries<TrafficDataByDate,String>(
                                dataSource: data.trafficSourceByDateModel.data![3].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: duckGoBarColor
                            ),
                            StackedColumnSeries<TrafficDataByDate,String>(
                                dataSource: data.trafficSourceByDateModel.data![4].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: baiduBarColor
                            ),
                            StackedColumnSeries<TrafficDataByDate,String>(
                                dataSource: data.trafficSourceByDateModel.data![4].data!,
                                xValueMapper: (TrafficDataByDate data, _) => data.key,
                                yValueMapper: (TrafficDataByDate data, _) => int.parse('${data.value}'),
                                width: 0.8,
                                color: otherTrafficBarColor
                            ),
                          ]
                      ),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                        child: ListView.builder(
                          itemCount: data.trafficSourceByDateModel.data!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index) => Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color:
                                  data.trafficSourceByDateModel.data![index] == data.trafficSourceByDateModel.data![0] ?
                                  directBarColor
                                  :data.trafficSourceByDateModel.data![index] == data.trafficSourceByDateModel.data![1] ?
                                  googleBarColor
                                      :data.trafficSourceByDateModel.data![index] == data.trafficSourceByDateModel.data![2] ?
                                  bingBarColor
                                      :data.trafficSourceByDateModel.data![index] == data.trafficSourceByDateModel.data![3] ?
                                  duckGoBarColor
                                      :data.trafficSourceByDateModel.data![index] == data.trafficSourceByDateModel.data![4] ?
                                  baiduBarColor
                                      :otherTrafficBarColor
                                ),

                                const SizedBox(width: 5),
                                Text(
                                  '${data.trafficSourceByDateModel.data![index].name}',
                                  style: graphHintTextStyle,
                                )
                              ],
                            ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    'Failed to load',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),


          const SizedBox(height: 10),
          // Circular chart - traffic source
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.trafficSourceLiveData().getValue();
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
              return Card(
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
                            // centerY: '100',
                            // centerX: '90',
                            margin: EdgeInsets.zero,
                            palette: const <Color>[
                              trafficSource1Color,
                              trafficSource2Color,
                              trafficSource3Color,
                              trafficSource4Color,
                              trafficSource5Color,
                              trafficSource6Color
                            ],
                            legend: Legend(
                              position: LegendPosition.right,
                              isVisible: true,
                              isResponsive:true,
                              overflowMode: LegendItemOverflowMode.wrap,
                            ),
                            series: <CircularSeries>[
                              DoughnutSeries<TrafficSourceData,String>(
                                dataSource: data.trafficSourceModel.data,
                                xValueMapper: (TrafficSourceData data,_) => data.key,
                                yValueMapper: (TrafficSourceData data,_) => data.value,
                                innerRadius: '65%',
                                radius: '80%',

                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    '',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 10),

          // what are the most visited pages heading + drop down menu
          // website list
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.mostVisitedPageLiveData().getValue();
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
                  Text(
                    'What are the most visited pages?',
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height:  data.mostVisitedPageModel.data!.length == 1 ||  data.mostVisitedPageModel.data!.length == 2?
                      120 :
                          data.mostVisitedPageModel.data!.length >= 3 && data.mostVisitedPageModel.data!.length <6 ?
                              220 :
                      data.mostVisitedPageModel.data!.length > 6 ?
                      395 : 320,
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

                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.mostVisitedPageModel.data!.length,
                                itemBuilder: (context,index) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 30),
                                            child: buildLineText(
                                              '${data.mostVisitedPageModel.data![index].key}',
                                              // style: tableContentTextStyle,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Text(
                                            '${data.mostVisitedPageModel.data![index].value}',
                                            style: tableContentTextStyle,
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    '',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 10),
          // What are the devices used heading + drop down
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.deviceCategoryLiveData().getValue();
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
                  Text(
                    'What are the devices used',
                    style: normalTextStyle,
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
                              desktopColor,
                              mobileColor,
                              tabletColor
                            ],
                            legend: Legend(
                              position: LegendPosition.right,
                              isVisible: true,
                              isResponsive:true,
                              overflowMode: LegendItemOverflowMode.wrap,
                            ),
                            series: <CircularSeries>[
                              DoughnutSeries<DeviceCategoryData,String>(
                                // animationDelay: 0,
                                // animationDuration: 0,
                                dataSource: data.deviceCategoryModel.data,
                                xValueMapper: (DeviceCategoryData data,_) => data.key,
                                yValueMapper: (DeviceCategoryData data,_) => data.value,
                                innerRadius: '65%',
                                radius: '70%',

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    '',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 10),
          // Search keyword list
          Consumer<AcquisitionProvider>(builder: (ctx, data, _){
            var state = data.searchKeywordLiveData().getValue();
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
                  Text(
                    'What did they search to find you?',
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 10),

                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Keywords',
                                style: tableTitleTextStyle,
                              ),

                              Text(
                                'No. Of Searches',
                                style: tableTitleTextStyle,
                              )
                            ],
                          ),

                          const SizedBox(height: 15),

                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.searchKeywordModel.data!.length,
                            itemBuilder: (context,index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Expanded(
                                    //   child: Align(
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Text(
                                    //       '${data.searchKeywordModel.data![index].keyword}'.replaceAll(RegExp(r'\s+'), ' '),
                                    //       style: tableContentTextStyle,
                                    //       textAlign: TextAlign.justify,
                                    //       overflow: TextOverflow.ellipsis,
                                    //     ),
                                    //   ),
                                    // ),

                                    Expanded(
                                      child: buildText(
                                        '${data.searchKeywordModel.data![index].keyword}'.replaceAll(RegExp(r'\s+'), ' ')
                                      ),
                                    ),
                                    const SizedBox(width: 90),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Text(
                                        '${data.searchKeywordModel.data![index].searches}',
                                        style: tableContentTextStyle,
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if (state is Failure) {
              return SizedBox();
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}

bool isReadMore = false;

Widget buildText(String text){
  return ReadMoreText(
    text,
    textAlign: TextAlign.left,
    style: tableReadMoreTextStyle,
    trimCollapsedText: 'Read More',
    trimExpandedText: ' Read Less',
    trimMode: TrimMode.Length,
    trimLength: 13,
    moreStyle: TextStyle(
      fontSize: 12,
      color: Colors.blue,
      fontFamily: 'Barlow-Regular'
    ),
    lessStyle: TextStyle(
        fontSize: 12,
        color: Colors.blue,
        fontFamily: 'Barlow-Regular'
    ),
  );
}

Widget buildLineText(String text){
  return ReadMoreText(
    text,
    textAlign: TextAlign.left,
    style: tableReadMoreTextStyle,
    trimCollapsedText: 'Read More',
    trimExpandedText: ' Read Less',
    trimMode: TrimMode.Line,
    trimLines: 1,
    // trimLength: 13,
    moreStyle: TextStyle(
        fontSize: 12,
        color: Colors.blue,
        fontFamily: 'Barlow-Regular'
    ),
    lessStyle: TextStyle(
        fontSize: 12,
        color: Colors.blue,
        fontFamily: 'Barlow-Regular'
    ),
  );
}

int findLargestValueAcrossLists(List<ChannelsByDateModelDatum> dataList) {
  int largestValue = 0; // Initialize with a default value

  for (var datum in dataList) {
    for (var valueData in datum.data!) {
      int value = int.parse('${valueData.value}');
      if (value > largestValue) {
        largestValue = value;
      }
    }
  }

  return largestValue;
}

int findLargestValueAcrossTrafficSource(List<TrafficSourceByDateModelDatum> dataList) {
  int largestValue = 0; // Initialize with a default value

  for (var datum in dataList) {
    for (var valueData in datum.data!) {
      int value = int.parse('${valueData.value}');
      if (value > largestValue) {
        largestValue = value;
      }
    }
  }

  return largestValue;
}

class ChartData{
  ChartData(this.x, this.y1, this.y2, this.y3);
  final String x;
  final double y1;
  final double y2;
  final double y3;
}

