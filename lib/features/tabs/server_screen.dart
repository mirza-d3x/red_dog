import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/providers/server_provider.dart';
import 'package:reddog_mobile_app/repositories/server_repository.dart';
import 'dart:math' as math;
import '../../core/ui_state.dart';
import '../../providers/registered_website_provider.dart';
import '../../repositories/common_repository.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../utilities/shared_prefernces.dart';
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


  dynamic _selectedFromDate;
  dynamic _selectedToDate;


  void _selectDateRange(BuildContext context) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: _selectedFromDate != null && _selectedToDate != null
          ? DateTimeRange(start: _selectedFromDate, end: _selectedToDate)
          : DateTimeRange(start: DateTime(2024, 3, 3), end: DateTime.now()),
    ).then((picked) {
      if (picked != null) {
        setState(() {
          deleteValue('storedFromDate');
          deleteValue('storedToDate');
          _selectedFromDate = picked.start;
          _selectedToDate = picked.end;
          setValue('storedFromDate', '${DateFormat('yyyy-MM-dd').format(_selectedFromDate) }');
          setValue('storedToDate', '${DateFormat('yyyy-MM-dd').format(_selectedToDate) }');
          getData();
        });
      }
    });
  }

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(
      commonRepository: CommonRepository());
  dynamic websiteName;
  dynamic websiteViewId ;

  ServerProvider serverProvider = ServerProvider(
      serverRepository: ServerRepository());


  getData() async{
    await getStoredDates();

     serverProvider.getServerTileItems(
        storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

     serverProvider.getLatencyValue(
         storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
         storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

     serverProvider.getUptimeValue(
         storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
         storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    await serverProvider.getSSLStatus();
  }

  bool isLoading = true;

  String storedStartDate = '';
  String storedEndDate = '';
  getStoredDates() async{
    storedStartDate = await getValue('storedFromDate');
    storedEndDate = await getValue('storedToDate');
    setState(() {
      isLoading = false; // Indicate that loading is complete
    });
  }

  String storedWeb = '';
  getStoredWeb() async{
    storedWeb = await getValue('storedWebSiteName');
  }

  @override
  void initState() {
    getStoredDates();
    getStoredWeb();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    getData();
    super.initState();
  }

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //initial from date
  String formattedInitialdDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: 30)));

  bool isSwitched = false;

  double _currentOffTime = 0;

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
                websiteDropdownMenu(),

                const SizedBox(height: 5),
                isLoading
                    ? CircularProgressIndicator() :
                InkWell(
                  onTap: () => _selectDateRange(context),
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
                          child:
                          storedStartDate.isNotEmpty && storedEndDate.isNotEmpty ?
                          Text(
                            storedStartDate+' to '+ storedEndDate,
                            style: dropDownTextStyle,
                          ):
                          Text(
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

                const SizedBox(height: 10),

                serverScreenWidget(),

              ],
            ),
          ),
        )
    );
  }

  Widget websiteDropdownMenu() {
    return ChangeNotifierProvider<RegisteredWebsiteProvider>(
      create: (ctx) {
        return registeredWebsiteProvider;
      },
      child: Consumer<RegisteredWebsiteProvider>(builder: (ctx, data, _) {
        var state = data.websiteListLiveData().getValue();
        print(state);
        if (state is IsLoading) {
          return SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 1.3,
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
                        hint:
                            storedWeb.isNotEmpty ?
                            Row(
                                children: [
                            Text(
                                storedWeb,
                                style: dropDownTextStyle
                            )
                                ]
                      ):
                        selectedWebsite == null
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
                            deleteValue('storedWebSiteName');
                            deleteValue('storedWebSiteViewId');
                            setState(()  {
                              deleteValue('websiteId');
                              selectedWebsite = val;
                              setValue('websiteId', val);
                              setValue('storedWebSiteName', data.websiteListModel.data!
                                  .firstWhere((element) => element.datumId == val)
                                  .name);
                              setValue('storedWebSiteViewId', data.websiteListModel.data!
                                  .firstWhere((element) => element.datumId == val).datumId);
                              getData();
                            });
                          })
                      ),
                    ),
                  ),
                ),
            ],
          );
        } else if (state is Failure) {
          return SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 1.3,
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
    );
  }

  Widget serverScreenWidget() {
    return ChangeNotifierProvider<ServerProvider>(
      create: (ctx) {
        return serverProvider;
      },
      child: Column(
        children: [
          Card(
            elevation: 2,
            shadowColor: whiteColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Server downtime Alerts Temporary Off',
                          style: tileTitleTextStyle,
                        ),
                        Switch(
                            value: isSwitched,
                            activeColor: whiteColor,
                            activeTrackColor: serverAlertOnColor,
                            inactiveThumbColor: whiteColor,
                            inactiveTrackColor: serverAlertOffColor,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            }),
                      ],
                    ),
                  ),

                  isSwitched == false ?
                      SizedBox()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                          thumbColor: serverAlertOnColor ,// Set the thumb color
                          activeTrackColor: sliderColor, // Set the active track color
                          inactiveTrackColor: sliderColor, // Set the inactive track color
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13.0),
                          trackHeight: 15,
                          trackShape: RectangularSliderTrackShape()// Customize the thumb shape and size
                          // overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0), // Customize the overlay shape and size
                                              ),
                            child: Slider(
                            value: _currentOffTime,
                            max: 24,
                            divisions: 24,
                            label: _currentOffTime.round().toString(),
                            onChanged: (double value){
                              setState(() {
                                _currentOffTime = value;
                              });
                            },
                            ),
                          ),

                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 20),
                            child: Row(
                              children: [
                                Text(
                                  '${_currentOffTime.toInt()}' + ' Hours',
                                  style: alertTextStyle,
                                ),

                                const SizedBox(width: 20),

                                TextButton(
                                  onPressed: (){},
                                  style: TextButton.styleFrom(
                                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                                    foregroundColor: Colors.white,
                                    backgroundColor: serverAlertOnColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child:
                                    // isLoading == true ?
                                    // Center(
                                    //   child: CircularProgressIndicator(
                                    //     color: whiteColor,
                                    //   ),
                                    // ) :
                                    Center(
                                      child: Text(
                                        'Save Changes',
                                        style: saveBtnTextStyle,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Consumer<ServerProvider>(builder: (ctx, data, _) {
                var state = data.uptimeLiveData().getValue();
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
                  return Expanded(
                    child: Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        // width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Server Uptime',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '${data.uptimeModel.data!.uptime}%',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is Failure) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Text(
                        '${data.uptimeModel.message}',
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),

              const SizedBox(width: 5),

              Consumer<ServerProvider>(builder: (ctx, data, _) {
                var state = data.serverTileLiveData().getValue();
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
                  return Expanded(
                    child: Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        // width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Site Uptime',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '${data.serverTileModel.data!.uptime}%',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is Failure) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Text(
                        '${data.uptimeModel.message}',
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Consumer<ServerProvider>(builder: (ctx, data, _) {
                var state = data.latencyLiveData().getValue();
                print(state);
                if (state is IsLoading) {
                  return SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: loginBgColor,
                      ),
                    ),
                  );
                } else if (state is Success) {
                  return Expanded(
                    child: Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        // width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Latency',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '${data.latencyModel.data!.latency} ms',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is Failure) {
                  return SizedBox(
                    // height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Text(
                          ''
                        // 'Failed to load',
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),

              const SizedBox(width: 5),

              Consumer<ServerProvider>(builder: (ctx, data, _) {
                var state = data.sslLiveData().getValue();
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
                  return Expanded(
                    child: Card(
                      elevation: 2,
                      shadowColor: whiteColor,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SSL Health',
                              style: tileTitleTextStyle,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              '${data.sslModel.data}',
                              style: tileNumberTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is Failure) {
                  return SizedBox(
                    // height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Text(
                          ''
                        // 'Failed to load',
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),

          const SizedBox(height: 8),

          Consumer<ServerProvider>(builder: (ctx, data, _) {
            var state = data.serverTileLiveData().getValue();
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
                shadowColor: whiteColor,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Domain Status',
                        style: tileTitleTextStyle,
                      ),

                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${data.serverTileModel.data!.domainStatus}',
                            style: tileNumberTextStyle,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Expiry',
                                style: tileTitleTextStyle,
                              ),
                              Text(
                                '${data.serverTileModel.data!.domainExpiry}',
                                style: expiryDateTextStyle,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Text(
                    '${data.uptimeModel.message}',
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),

        ],
      )
    );
  }
}
