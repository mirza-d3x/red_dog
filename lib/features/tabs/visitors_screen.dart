import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/features/common/notification_list_screen.dart';
import 'package:reddog_mobile_app/features/visitor_graph/large_value_graph.dart';
import 'package:reddog_mobile_app/features/visitor_graph/normal_graph.dart';
import 'package:reddog_mobile_app/models/user_by_gender_model.dart';
import 'package:reddog_mobile_app/models/visitor_info_tile_model.dart';
import 'package:reddog_mobile_app/providers/logout_provider.dart';
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
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {

  UserProfileProvider userProfileProvider = UserProfileProvider(userRepository: UserRepository());

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());

  VisitorProvider visitorProvider = VisitorProvider(visitorRepository: VisitorRepository());

  LogoutProvider logoutProvider = LogoutProvider(commonRepository: CommonRepository());

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

  getUserByNewReturnedMethod() async{
    await visitorProvider.getUserByNewReturnedList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByCountryMethod() async{
    await visitorProvider.getUserByCountryList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByCityMethod() async{
    await visitorProvider.getUserByCityList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByLangMethod() async{
    await visitorProvider.getUserByLangList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByAgeGroupMethod() async{
    await visitorProvider.getUserByAgeList(
        _selectedFromDate != null ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}' : formattedDate
    );
  }

  getUserByGenderMethod() async{
    await visitorProvider.getUserByGenderList(
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

  late List<Model> _data;
  late MapShapeSource _mapSource;

  @override
  void initState(){
    super.initState();
    getStoredWebsiteId();
    deleteValue('websiteId');
    userProfileProvider.getProfile();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    getVisitorTileMethod();
    getUserByTrendingTimeMethod();
    getUserByNewReturnedMethod();
    getUserByCountryMethod();
    getUserByCityMethod();
    getUserByLangMethod();
    getUserByAgeGroupMethod();
    getUserByGenderMethod();

    _data = const <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
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
        getUserByNewReturnedMethod();
        getUserByCountryMethod();
        getUserByCityMethod();
        getUserByLangMethod();
        getUserByAgeGroupMethod();
        getUserByGenderMethod();
      });
    }
  }

  // Declaration for coutry list
  String selectedOption = 'Country';

  final List<CountryData> countriesData = [
    CountryData('India', Colors.blue),
    CountryData('China', Colors.red),
    // Add more countries and colors as needed
  ];

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
                            onLogout();
                            // deleteValue('token');
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            // });
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
                                getUserByTrendingTimeMethod();
                                getUserByNewReturnedMethod();
                                getUserByCountryMethod();
                                getUserByCityMethod();
                                getUserByLangMethod();
                                getUserByAgeGroupMethod();
                                getUserByGenderMethod();
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
                      ),
                    ),
                  ],
                )
            ),
          ),

          const SizedBox(height: 15),
          // Retained visitors
          Text(
            'Retained visitors',
            style: normalTextStyle,
          ),

          const SizedBox(height: 10),
          Consumer<VisitorProvider>(builder: (ctx, data, _){
            var state = data.userByNewReturnedLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox();
            } else if (state is Success) {
              return Card(
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
                            graphBlackColor,
                            graphGreyColor,
                          ],
                          legend: Legend(
                            position: LegendPosition.right,
                            isVisible: true,
                            isResponsive:true,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                          series: <CircularSeries>[
                            DoughnutSeries<NewReturnedData,String>(
                              dataSource: data.userByNewReturnedModel.data,
                              xValueMapper: (NewReturnedData data,_) => data.key,
                              yValueMapper: (NewReturnedData data,_) => data.value,
                              innerRadius: '90%',
                              radius: '60%',
                            ),
                          ],
                        ),

                        // Positioned(
                        //   left: 73,
                        //   top: 93,
                        //   child: Text(
                        //     '25.7%',
                        //     style: visitorGraphValueTextStyle,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
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
          // Where are your users from?
          Text(
            'Your Visitors from?',
            style: normalTextStyle,
          ),

          const SizedBox(height: 10),
          // // world map
          // Card(
          //   elevation: 2,
          //   shadowColor: whiteColor,
          //   child: Container(
          //     padding: const EdgeInsets.all(10),
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(3),
          //       color: whiteColor,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 15,top: 15),
          //       child:
          //
          //       SimpleMap(
          //         instructions: SMapWorld.instructions,
          //         defaultColor: Colors.grey,
          //         colors: const SMapWorldColors(
          //           uS: Colors.green,   // This makes USA green
          //           dE: Colors.red,   // This makes China green
          //           iN: Colors.green,   // This makes Russia green
          //         ).toMap(),
          //         callback: (id, name, tapDetails) {
          //           print(id);
          //         },
          //       ),
          //     ),
          //   ),
          // ),

          // API  world map
          Consumer<VisitorProvider>(builder: (ctx, data, _){
            var state = data.userByCountryLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox();
            } else if (state is Success) {
              return Card(
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
                    child:
                      SizedBox(
                          height: 180,
                          child: Center(
                            child: SfMaps(
                              layers: <MapShapeLayer>[
                                MapShapeLayer(
                                  source: MapShapeSource.asset(
                                    'assets/world_map.json',
                                    shapeDataField: 'name',
                                    dataCount: data.userByCountryModel.data!.length,
                                    primaryValueMapper: (int index) => data.userByCountryModel.data![index].name,
                                    shapeColorValueMapper: (int index) => Colors.green,
                                  ),
                                  showDataLabels: false,
                                ),
                              ],
                            ),
                          )
                      )
                  ),
                ),
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
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Users',
                          style: tableTitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
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
                        padding: const EdgeInsets.only(left: 45),
                        child: Text(
                          'Users',
                          style: tableTitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
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
                  //  country list
                  Consumer<VisitorProvider>(builder: (ctx, data, _){
                    var state = data.userByCountryLiveData().getValue();
                    print(state);
                    if (state is IsLoading) {
                      return SizedBox();
                    } else if (state is Success) {
                      return Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: ListView.builder(
                              itemCount: data.userByCountryModel.data!.length,
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

                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${data.userByCountryModel.data![index].name}',
                                              style: tableContentTextStyle,
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${data.userByCountryModel.data![index].value}',
                                              style: tableContentTextStyle,
                                            ),
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: LinearPercentIndicator(
                                              width: 65.0,
                                              lineHeight: 14.0,
                                              percent: data.userByCountryModel.data![index].percentage / 100, //percent value must be between 0.0 and 1.0
                                              backgroundColor: whiteColor,
                                              progressColor: percentageIndicatorColor,
                                              center: Text(
                                                '${data.userByCountryModel.data![index].percentage}',
                                                style: percentTextStyle,
                                              ),
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
                  }):
                  Consumer<VisitorProvider>(builder: (ctx, data, _){
                    var state = data.userByCityLiveData().getValue();
                    print(state);
                    if (state is IsLoading) {
                      return SizedBox();
                    } else if (state is Success) {
                      return Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: ListView.builder(
                              itemCount: data.userByCityModel.data!.length,
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

                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${data.userByCityModel.data![index].name}',
                                              style: tableContentTextStyle,
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${data.userByCityModel.data![index].value}',
                                              style: tableContentTextStyle,
                                            ),
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: LinearPercentIndicator(
                                              width: 65.0,
                                              lineHeight: 14.0,
                                              percent: data.userByCityModel.data![index].percentage / 100, //percent value must be between 0.0 and 1.0
                                              backgroundColor: whiteColor,
                                              progressColor: percentageIndicatorColor,
                                              center: Text(
                                                '${data.userByCityModel.data![index].percentage}',
                                                style: percentTextStyle,
                                              ),
                                            ),
                                          ),
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
                  })
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
          // language list
          Consumer<VisitorProvider>(builder: (ctx, data, _){
            var state = data.userByLangLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox();
            } else if (state is Success) {
              return Card(
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

                            Text(
                              'Users',
                              style: tableTitleTextStyle,
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
                              itemCount: data.userByLangModel.data!.length,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context,index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   '${index + 1}',
                                        //   style: tableContentTextStyle,
                                        // ),

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${data.userByLangModel.data![index].language}',
                                            style: tableContentTextStyle,
                                          ),
                                        ),


                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${data.userByLangModel.data![index].usercount}',
                                            style: tableContentTextStyle,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: LinearPercentIndicator(
                                            width: 65.0,
                                            lineHeight: 14.0,
                                            percent:
                                            double.parse(data.userByLangModel.data![index].percentage) / 100,
                                            // 0.8, //percent value must be between 0.0 and 1.0
                                            backgroundColor: whiteColor,
                                            progressColor: percentageIndicatorColor,
                                            center: Text(
                                              '${data.userByLangModel.data![index].percentage}',
                                              style: percentTextStyle,
                                            ),
                                          ),
                                        ),


                                        // Text(
                                        //   '83.10%',
                                        //   style: tableContentTextStyle,
                                        // )
                                      ],
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
              child: userByAgeWidget(),
              // buildBarChart(),
            ),
          ),

          const SizedBox(height: 15),
          // What is their gender?
          Text(
            'What is their gender?',
            style: normalTextStyle,
          ),

          const SizedBox(height: 10),
          Consumer<VisitorProvider>(builder: (ctx, data, _){
            var state = data.userByGenderLiveData().getValue();
            print(state);
            if (state is IsLoading) {
              return SizedBox();
            } else if (state is Success) {
              return Card(
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
                            femaleIndicatorColor,
                            maleIndicatorColor,
                          ],
                          legend: Legend(
                            position: LegendPosition.right,
                            isVisible: true,
                            isResponsive:true,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                          series: <CircularSeries>[
                            DoughnutSeries<Datum,String>(
                              dataSource: data.userByGenderModel.data,
                              xValueMapper: (Datum data,_) => data.key,
                              yValueMapper: (Datum data,_) => data.value,
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
                child:
                    int.parse('${data.userByVisitorsTrendingTimeModel.data![0].value}').toInt() > 20?
                // LineChart(
                //     mainDataForGreaterValues(data.userByVisitorsTrendingTimeModel.data ?? [])
                // )
                       LargeValueGraph(
                           _selectedFromDate != null ?
                           '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
                           _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}'
                               : formattedDate
                       ) : NormalGraph(
                        _selectedFromDate != null ?
                        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}' : formattedInitialdDate,
                        _selectedToDate != null ?  '${DateFormat('yyyy-MM-dd').format(_selectedToDate)}'
                            : formattedDate
                    ),
                    //     : LineChart(
                    //     mainData(data.userByVisitorsTrendingTimeModel.data ?? [])
                    // )
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

  Widget userByAgeWidget(){
    return ChangeNotifierProvider<VisitorProvider>(
      create: (ctx) {
        return visitorProvider;
      },
      child: Consumer<VisitorProvider>(
        builder: (ctx, data, _) {
          var state = data.userByAgeGroupLiveData().getValue();
          print(state);
          if (state is IsLoading) {
            return SizedBox();
          }else if (state is Success) {
            List<charts.Series<AgeData, String>> series = [
              charts.Series(
                  id: '',
                  data: data.userByAgeGroupModel.data!,
                  domainFn: (AgeData sales, _) => sales.key,
                  measureFn: (AgeData sales, _) => int.parse(sales.value),
                  colorFn: (_, __) => charts.ColorUtil.fromDartColor(graphBlackColor),
                  // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                  labelAccessorFn: (AgeData sales, _) => '${sales.value}',
                  outsideLabelStyleAccessorFn: (AgeData sales, _){
                    return  const charts.TextStyleSpec(
                      fontFamily: 'Barlow-Bold',
                      color:  charts.MaterialPalette.black,
                      fontSize: 13,
                    );
                  },
                  insideLabelStyleAccessorFn: (AgeData sales, _){
                    return  const charts.TextStyleSpec(
                      fontFamily: 'Barlow-Bold',
                      color:  charts.MaterialPalette.white,
                      fontSize: 16,
                    );
                  }
              ),
            ];

            // Calculate maximum value
            int maxValue = data.userByAgeGroupModel.data!
                .map((e) => int.parse(e.value))
                .reduce((value, element) => value > element ? value : element);

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
                    tickProviderSpec:
                    charts.StaticNumericTickProviderSpec(
                      // Custom ticks from 0 to 20 with an interval of 4
                        maxValue >= 50 && maxValue == 300 ?
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(60),
                          charts.TickSpec<num>(120),
                          charts.TickSpec<num>(180),
                          charts.TickSpec<num>(240),
                          charts.TickSpec<num>(300),
                        ] :
                        maxValue >300 && maxValue == 1000  ?
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(200),
                          charts.TickSpec<num>(400),
                          charts.TickSpec<num>(600),
                          charts.TickSpec<num>(800),
                          charts.TickSpec<num>(100),
                        ] :
                        maxValue > 1000 ?
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(500),
                          charts.TickSpec<num>(1000),
                          charts.TickSpec<num>(1500),
                          charts.TickSpec<num>(2000),
                          charts.TickSpec<num>(2500),
                        ] :
                        maxValue <= 15 ?
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(3),
                          charts.TickSpec<num>(6),
                          charts.TickSpec<num>(9),
                          charts.TickSpec<num>(12),
                          charts.TickSpec<num>(15),
                        ] :
                        maxValue >15 && maxValue == 50  ?
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(10),
                          charts.TickSpec<num>(20),
                          charts.TickSpec<num>(30),
                          charts.TickSpec<num>(40),
                          charts.TickSpec<num>(50),
                        ] :
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>(15),
                          charts.TickSpec<num>(30),
                          charts.TickSpec<num>(45),
                          charts.TickSpec<num>(60),
                          charts.TickSpec<num>(75),
                        ]

                    ),
                    tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                          (value) => '${value!.toInt()}',
                    ),
                  ),

                  //  display values on bars

                  barRendererDecorator: charts.BarLabelDecorator<String>(
                    labelPosition: maxValue > 1000 ?
                    charts.BarLabelPosition.outside : charts.BarLabelPosition.inside,// Position of the label
                    labelAnchor: charts.BarLabelAnchor.middle, // Anchor point of the label
                    labelPadding: 4, // Padding around the label
                  ),
                  // behaviors: [charts.SeriesLegend()],
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

  Widget bottomTitleWidgetsForGreaterValues(double value, TitleMeta meta) {
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

  Widget leftTitleWidgetsForGreaterValues(double value, TitleMeta meta) {
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

  LineChartData mainDataForGreaterValues(List<TrendingTimeData> data) {
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
            getTitlesWidget: bottomTitleWidgetsForGreaterValues,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 40,
            getTitlesWidget: leftTitleWidgetsForGreaterValues,
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

  onLogout() async {
     await logoutProvider.logoutFromDevice();
      deleteValue('token');
      deleteValue('fireBaseToken');
      deleteValue('googleToken');
      deleteValue('email');
      deleteValue('analytics');
      deleteValue('googleId');
      deleteValue('websiteId');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}

class CountryData {
  final String name;
  final Color color;

  CountryData(this.name, this.color);
}

class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}
