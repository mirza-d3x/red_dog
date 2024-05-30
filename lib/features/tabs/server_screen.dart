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

  // void _selectDateRange(BuildContext context) async {
  //   final picked = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime.now(),
  //     initialDateRange: _selectedFromDate != null && _selectedToDate != null
  //         ? DateTimeRange(start: _selectedFromDate, end: _selectedToDate)
  //         : DateTimeRange(start: DateTime(2024, 3, 3), end: DateTime.now()),
  //   );
  //
  //   if (picked != null) {
  //     setState(() {
  //       _selectedFromDate = picked.start;
  //       _selectedToDate = picked.end;
  //       getData();
  //       // serverProvider.getLatencyValue(
  //       //     _selectedFromDate != null
  //       //         ?
  //       //     '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
  //       //         : formattedInitialdDate,
  //       //     _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
  //       //         _selectedToDate)}' : formattedDate
  //       // );
  //       // serverProvider.getUptimeValue(
  //       //     _selectedFromDate != null
  //       //         ?
  //       //     '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
  //       //         : formattedInitialdDate,
  //       //     _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
  //       //         _selectedToDate)}' : formattedDate
  //       // );
  //     });
  //   }
  // }

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
          _selectedFromDate = picked.start;
          _selectedToDate = picked.end;
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
    await serverProvider.getLatencyValue(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    await serverProvider.getUptimeValue(
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
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
    print(storedStartDate);
    print(storedEndDate);
  }

  @override
  void initState() {
    getStoredDates();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    getData();
    super.initState();
  }

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //initial from date
  String formattedInitialdDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: 30)));

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

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     tiles(context, 'Average page load time', '6.03 ms'),
                //     tiles(context, 'Average server response time', '0.47 ms'),
                //   ],
                // ),
                //
                // const SizedBox(height: 8),

                serverScreenWidget(),

                // const SizedBox(height: 8),

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
          Consumer<ServerProvider>(builder: (ctx, data, _) {
            var state = data.uptimeLiveData().getValue();
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
                        'Uptime',
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

          const SizedBox(height: 8),

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

          const SizedBox(height: 8),

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
      )
    );
  }
}
