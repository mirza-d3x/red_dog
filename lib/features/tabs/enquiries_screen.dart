import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/features/filter/filter_screen.dart';
import 'package:reddog_mobile_app/features/notes/add_notes_screen.dart';
import 'package:reddog_mobile_app/features/serach/search_screen.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';
import 'package:reddog_mobile_app/widgets/infotiles.dart';

import '../../core/ui_state.dart';
import '../../models/checkbox_model.dart';
import '../../providers/registered_website_provider.dart';
import '../../repositories/common_repository.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../utilities/shared_prefernces.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/tiles.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {

  dynamic selectedWebsite;
  bool isSelectedFromDropDwn = false;

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
        deleteValue('storedFromDate');
        deleteValue('storedToDate');
        _selectedFromDate = picked.start;
        _selectedToDate = picked.end;
        setValue('storedFromDate', '${DateFormat('yyyy-MM-dd').format(_selectedFromDate) }');
        setValue('storedToDate', '${DateFormat('yyyy-MM-dd').format(_selectedToDate) }');
        getEnquiryCountMethod();
      });
    }
  }

  TextEditingController searchKeywordController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // Format the current date in "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  dynamic selectedValue;
  bool isSortSelected = false;
  dynamic sortOrder;

  String errorMessage = "";
  bool validateNote(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        errorMessage = "Enter a note before pressing submit button";
      });
      return false;
    } else {
      setState(() {
        errorMessage = "";
      });
      return true;
    }
  }

  onSubmit(){
    final isValidNote = validateNote(noteController.text);
    if(isValidNote){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(false)));
    }
  }


  bool isOpenedNewMessage = false;
  bool isLoading = false;

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());
  dynamic websiteName ;
  EnquiryProvider enquiryProvider = EnquiryProvider(enquiryRepository: EnquiryRepository());

  //initial from date
  String formattedInitialdDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: 30)));

  getEnquiryCountMethod() async{
    await getStoredDates();
    enquiryProvider.getUnreadEnquiryList(
        storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    enquiryProvider.getEnquiryList(
        storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );

    enquiryProvider.getEnquiryLeadDetailsList(
        storedStartDate.isNotEmpty ? storedStartDate :
        _selectedFromDate != null
            ?
        '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
            : formattedInitialdDate,
        storedEndDate.isNotEmpty ? storedEndDate :
        _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
            _selectedToDate)}' : formattedDate
    );
  }

  dynamic websiteViewId ;

  bool isUILoading = true;

  String storedStartDate = '';
  String storedEndDate = '';
  getStoredDates() async{
    storedStartDate = await getValue('storedFromDate');
    storedEndDate = await getValue('storedToDate');
    setState(() {
      isUILoading = false; // Indicate that loading is complete
    });
  }

  String storedWeb = '';
  getStoredWeb() async{
    storedWeb = await getValue('storedWebSiteName');
  }

  @override
  void initState(){
    getStoredDates();
    getStoredWeb();
    registeredWebsiteProvider.getRegisteredWebsiteList();
    getEnquiryCountMethod();
    super.initState();
  }

  bool onTileTap = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Enquiries'),
          backgroundColor: bgColor,
          body:
          // noEnquiryWidget(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // drop dwn menu,calander,download button
                websiteDropdownMenu(),

                const SizedBox(height: 5),
                isUILoading
                    ? CircularProgressIndicator() :
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
                          child: storedStartDate.isNotEmpty && storedEndDate.isNotEmpty ?
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

                enquiryUiWidget(),

                const SizedBox(height: 15),

              ],
            ),
          ),
        )
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
                        hint: storedWeb.isNotEmpty ?
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
                              getEnquiryCountMethod();
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

  Widget noEnquiryWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Website Login Required',
            style: errorTitleTextStyle,
          ),
          const SizedBox(height: 15),
          Text(
            'To continue, please login through the Web app and integrate the script '
                'into your website forms to effectively capture leads.',
            textAlign: TextAlign.center,
            style: messageTextStyle,
          ),

          const SizedBox(height: 15),
          Text(
            'For further assistance, contact askus@codelattice.com',
            textAlign: TextAlign.center,
            style: errorSubTextStyle,
          )
        ],
      ),
    );
  }

  void searchModal(BuildContext context){
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(5.0)),
      ),
        context: context,
        builder: (context){
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  cursorColor: blackColor,
                  cursorHeight: 21,
                  controller: searchKeywordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 4,left: 10),
                    hintText: 'Search for your data',
                    // hintStyle: searchTextStyle,
                    filled: true,
                    fillColor: whiteColor,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        if (searchKeywordController.text.isEmpty) {
                          Dialog(
                            child: Container(
                              height: 305,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                          final snackBar = SnackBar(
                            backgroundColor: loginBgColor,
                            content: Container(
                              height: 30,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Please enter a keyword to search',
                                    style:
                                    TextStyle(color: blackColor),
                                  )),
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             SearchProductList(searchKeywordController.text)
                          //     ));
                        }
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: buildTextFormColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: boxColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        },
    );
  }

  Widget enquiryUiWidget(){
    return ChangeNotifierProvider<EnquiryProvider>(
      create: (ctx){
        return enquiryProvider;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<EnquiryProvider>(builder: (ctx, data, _){
            var state = data.enquiryCountLiveData().getValue();
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
              return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                itemCount: data.enquiryCountModel.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                      mainAxisExtent: 98
                  ),
                  itemBuilder: (BuildContext context,index) =>
                      InkWell(
                        onTap: (){
                          setState(() {
                            onTileTap = true;
                          });
                          enquiryProvider.getEnquiryLeadDetailsWithTileList(
                              _selectedFromDate != null
                                  ?
                              '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
                                  : formattedInitialdDate,
                              _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
                                  _selectedToDate)}' : formattedDate,
                              '${data.enquiryCountModel.data![index].category}'
                          );
                        },
                        child: tiles(context,
                            '${data.enquiryCountModel.data![index].category}',
                            '${data.enquiryCountModel.data![index].count}'),
                      )
              );
            }else if (state is Failure) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Center(
                  child: noEnquiryWidget()
                ),
              );
            } else {
              return Container();
            }
          }),

          Consumer<EnquiryProvider>(builder: (ctx, data, _){
            var state = data.enquiryLeadDetailsLiveData().getValue();
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
              return InkWell(
                onTap: (){
                  setState(() {
                    onTileTap = false;
                  });
                },
                child: tiles(context,
                    'Total',
                    '${data.enquiryLeadDetailsModel.total}'),
              );
            }else if (state is Failure) {
              return SizedBox();
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 15),

          // lead Details enquiries read & unread
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lead Details',
                style: normalTextStyle,
              ),

              Row(
                children: [
                  Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
                      },
                      child: Container(
                          height: 43,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.search_outlined,
                            color: blackColor,
                            size: 22,
                          )
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),

                  InkWell(
                    onTap: (){
                      // filterModalSheet(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen()));
                    },
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
                            Icons.filter_alt_outlined,
                            color: blackColor,
                            size: 22,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

         onTileTap == true ? filterWithTileWidget() : allEnquiryWidget(),

             // Consumer<EnquiryProvider>(builder: (ctx, data, _){
             //   var state = data.enquiryLeadDetailsLiveData().getValue();
             //   print(state);
             //   if (state is IsLoading) {
             //     return SizedBox(
             //       height: MediaQuery.of(context).size.height / 1.3,
             //       child: Center(
             //         child: CircularProgressIndicator(
             //           color: loginBgColor,
             //         ),
             //       ),
             //     );
             //   } else if (state is Success) {
             //     return ListView.builder(
             //       physics: const NeverScrollableScrollPhysics(),
             //       shrinkWrap: true,
             //       itemCount: data.enquiryLeadDetailsModel.data!.length,
             //       itemBuilder: (context, index) => Column(
             //         crossAxisAlignment: CrossAxisAlignment.start,
             //         children: [
             //           InkWell(
             //             onTap: (){
             //               showModalBottomSheet(
             //                 enableDrag: true,
             //                 isScrollControlled: true,
             //                 shape: const RoundedRectangleBorder(
             //                   borderRadius: BorderRadius.only(
             //                       topLeft: Radius.circular(25.0), topRight: Radius.circular(5.0)),
             //                 ),
             //                 context: context,
             //                 builder: (context){
             //                   return Padding(
             //                     padding: EdgeInsets.fromLTRB(
             //                       20, 30, 20,
             //                       MediaQuery.of(context).viewInsets.bottom,
             //                     ),
             //                     child: SingleChildScrollView(
             //                       child: Column(
             //                         crossAxisAlignment: CrossAxisAlignment.start,
             //                         children: [
             //                           // name
             //                           Text('${data.enquiryLeadDetailsModel.data![index].name}',
             //                             style: nameTextStyle,
             //                           ),
             //                           const SizedBox(height: 10),
             //
             //                           // email
             //                           Row(
             //                             children: [
             //                               const Icon(
             //                                 Icons.email_outlined,
             //                                 size: 15,
             //                                 color: titleTextColor,
             //                               ),
             //
             //                               const SizedBox(width: 5),
             //
             //                               Text(
             //                                 '${data.enquiryLeadDetailsModel.data![index].email}',
             //                                 style: subTextTextStyle,
             //                               )
             //                             ],
             //                           ),
             //
             //                           const SizedBox(height: 7),
             //
             //                           // contact number
             //                           InkWell(
             //                             onTap: (){
             //                               FlutterPhoneDirectCaller.callNumber('+91${data.enquiryLeadDetailsModel.data![index].phone}');
             //                             },
             //                             child: Row(
             //                               children: [
             //                                 const Icon(
             //                                   Icons.phone_enabled,
             //                                   size: 15,
             //                                   color: titleTextColor,
             //                                 ),
             //
             //                                 const SizedBox(width: 5),
             //
             //                                 Text(
             //                                   '+91 ${data.enquiryLeadDetailsModel.data![index].phone}',
             //                                   style: subTextTextStyle,
             //                                 )
             //                               ],
             //                             ),
             //                           ),
             //
             //                           //  Calendar
             //                           const SizedBox(height: 7),
             //                           Row(
             //                             children: [
             //                               const Icon(
             //                                 Icons.calendar_month,
             //                                 size: 15,
             //                                 color: titleTextColor,
             //                               ),
             //
             //                               const SizedBox(width: 5),
             //                               Text(
             //                                 formatDateFromAPI(
             //                                     '${data.enquiryLeadDetailsModel.data![index].date}'
             //                                 ),
             //                                 style: subTextTextStyle,
             //                               ),
             //
             //                               const SizedBox(width: 15),
             //
             //                               const Icon(
             //                                 CupertinoIcons.arrow_down_left,
             //                                 size: 15,
             //                                 color: titleTextColor,
             //                               ),
             //                               const SizedBox(width: 3),
             //                               Text(
             //                                 '${data.enquiryLeadDetailsModel.data![index].category}',
             //                                 style: subTextTextStyle,
             //                               ),
             //                             ],
             //                           ),
             //
             //                           // messages
             //                           const SizedBox(height: 7),
             //                           Row(
             //                             mainAxisAlignment: MainAxisAlignment.start,
             //                             crossAxisAlignment: CrossAxisAlignment.start,
             //                             children: [
             //                               Padding(
             //                                 padding: const EdgeInsets.only(top: 3),
             //                                 child: const Icon(
             //                                   Icons.message_outlined,
             //                                   size: 15,
             //                                   color: titleTextColor,
             //                                 ),
             //                               ),
             //
             //                               const SizedBox(width: 5),
             //                               Expanded(
             //                                 child:
             //                                 '${data.enquiryLeadDetailsModel.data![index].message}' == "" ?
             //                                 Text(
             //                                   'No message',
             //                                   style: subTextTextStyle,
             //                                 ) :
             //                                 Text(
             //                                   '${data.enquiryLeadDetailsModel.data![index].message}',
             //                                   style: subTextTextStyle,
             //                                 ),
             //                               )
             //                             ],
             //                           ),
             //
             //                           const SizedBox(height: 15),
             //                           Text(
             //                             'Comments',
             //                             style: noteHeadingTextStyle,
             //                           ),
             //
             //                           const SizedBox(height: 10),
             //
             //                           AddNotesWidget(
             //                               '${data.enquiryLeadDetailsModel.data![index].id}'
             //                           ),
             //                         ],
             //                       ),
             //                     ),
             //                   );
             //                 },
             //               ).then((value) {
             //                 enquiryProvider.updateEnquiryStatus(
             //                     data.enquiryLeadDetailsModel.data![index].id
             //                 );
             //                 getEnquiryCountMethod();
             //               });
             //             },
             //             child: Card(
             //               elevation: 2,
             //               child: Container(
             //                   width: double.infinity,
             //                   decoration: BoxDecoration(
             //                     color:
             //                         data.enquiryLeadDetailsModel.data![index].status == false ?
             //                         highlightingColor :
             //                     whiteColor,
             //                     borderRadius: BorderRadius.circular(2),
             //                   ),
             //                   padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
             //                   child: IntrinsicHeight(
             //                     child: Column(
             //                       crossAxisAlignment: CrossAxisAlignment.start,
             //                       children: [
             //                         Row(
             //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //                           children: [
             //                             Text(
             //                               '${data.enquiryLeadDetailsModel.data![index].name}',
             //                               style: nameTextStyle,
             //                             ),
             //
             //                             PopupMenuButton(
             //                               child: Icon(
             //                                 Icons.more_vert_outlined,
             //                                 size: 20,
             //                               ),
             //                               itemBuilder: (BuildContext context) {
             //                                 return <PopupMenuItem<String>>[
             //                                   PopupMenuItem<String>(
             //                                     child: TextButton(
             //                                       child: Row(
             //                                         mainAxisAlignment:
             //                                         MainAxisAlignment.start,
             //                                         children: [
             //                                           Text(
             //                                             'Mark as Unread',
             //                                             style: popupMenuTextStyle,
             //                                           ),
             //                                         ],
             //                                       ),
             //                                       onPressed: () {
             //                                         enquiryProvider.updateEnquiryStatus(
             //                                             data.enquiryLeadDetailsModel.data![index].id
             //                                         );
             //                                         getEnquiryCountMethod();
             //                                         Navigator.pop(context);
             //                                       },
             //                                     ),
             //                                     height: 31,
             //                                   ),
             //                                 ];
             //                               },
             //                             )
             //                           ],
             //                         ),
             //
             //                         const SizedBox(height: 8),
             //
             //                         Row(
             //                           children: [
             //                             const Icon(
             //                               Icons.email_outlined,
             //                               size: 15,
             //                               color: titleTextColor,
             //                             ),
             //
             //                             const SizedBox(width: 5),
             //
             //                             Text(
             //                               '${data.enquiryLeadDetailsModel.data![index].email}',
             //                               style: subTextTextStyle,
             //                             )
             //                           ],
             //                         ),
             //
             //                         const SizedBox(height: 5),
             //                         InkWell(
             //                           onTap: (){
             //                             FlutterPhoneDirectCaller.callNumber('+91${data.enquiryLeadDetailsModel.data![index].phone}');
             //                           },
             //                           child: Row(
             //                             children: [
             //                               const Icon(
             //                                 Icons.phone_enabled,
             //                                 size: 15,
             //                                 color: titleTextColor,
             //                               ),
             //
             //                               const SizedBox(width: 5),
             //
             //                               Text(
             //                                 '+91 ${data.enquiryLeadDetailsModel.data![index].phone}',
             //                                 style: subTextTextStyle,
             //                               )
             //                             ],
             //                           ),
             //                         ),
             //                       ],
             //                     ),
             //                   )
             //               ),
             //             ),
             //           ),
             //
             //           const SizedBox(height: 7),
             //         ],
             //       ),
             //     );
             //   }else if (state is Failure) {
             //     return SizedBox();
             //   } else {
             //     return Container();
             //   }
             // }),
        ],
      ),
    );
  }

  Widget filterWithTileWidget(){
    return ChangeNotifierProvider<EnquiryProvider>(
      create: (ctx){
        return enquiryProvider;
      },
      child: Consumer<EnquiryProvider>(builder: (ctx, data, _){
        var state = data.leadDetailsWithTileFilterLiveData().getValue();
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
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.leadDetailsWithTileFilterModel.data!.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0), topRight: Radius.circular(5.0)),
                      ),
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            20, 30, 20,
                            MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // name
                                Text('${data.leadDetailsWithTileFilterModel.data![index].name}',
                                  style: nameTextStyle,
                                ),
                                const SizedBox(height: 10),

                                // email
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      '${data.leadDetailsWithTileFilterModel.data![index].email}',
                                      style: subTextTextStyle,
                                    )
                                  ],
                                ),

                                const SizedBox(height: 7),

                                // contact number
                                InkWell(
                                  onTap: (){
                                    FlutterPhoneDirectCaller.callNumber('+91${data.leadDetailsWithTileFilterModel.data![index].phone}');
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_enabled,
                                        size: 15,
                                        color: titleTextColor,
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        '+91 ${data.leadDetailsWithTileFilterModel.data![index].phone}',
                                        style: subTextTextStyle,
                                      )
                                    ],
                                  ),
                                ),

                                //  Calendar
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),
                                    Text(
                                      formatDateFromAPI(
                                          '${data.leadDetailsWithTileFilterModel.data![index].date}'
                                      ),
                                      style: subTextTextStyle,
                                    ),

                                    const SizedBox(width: 15),

                                    const Icon(
                                      CupertinoIcons.arrow_down_left,
                                      size: 15,
                                      color: titleTextColor,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${data.leadDetailsWithTileFilterModel.data![index].category}',
                                      style: subTextTextStyle,
                                    ),
                                  ],
                                ),

                                // messages
                                const SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: const Icon(
                                        Icons.message_outlined,
                                        size: 15,
                                        color: titleTextColor,
                                      ),
                                    ),

                                    const SizedBox(width: 5),
                                    Expanded(
                                      child:
                                      '${data.leadDetailsWithTileFilterModel.data![index].message}' == "" ?
                                      Text(
                                        'No message',
                                        style: subTextTextStyle,
                                      ) :
                                      Text(
                                        '${data.leadDetailsWithTileFilterModel.data![index].message}',
                                        style: subTextTextStyle,
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 15),
                                Text(
                                  'Comments',
                                  style: noteHeadingTextStyle,
                                ),

                                const SizedBox(height: 10),

                                AddNotesWidget(
                                    '${data.leadDetailsWithTileFilterModel.data![index].id}'
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).then((value) {
                      enquiryProvider.updateEnquiryStatus(
                          data.leadDetailsWithTileFilterModel.data![index].id
                      );
                      enquiryProvider.getEnquiryLeadDetailsWithTileList(
                          _selectedFromDate != null
                              ?
                          '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
                              : formattedInitialdDate,
                          _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
                              _selectedToDate)}' : formattedDate,
                          '${data.leadDetailsWithTileFilterModel.data![index].category}'
                      );
                      getEnquiryCountMethod();
                    });
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              data.leadDetailsWithTileFilterModel.data![index].status == false ?
                                  highlightingColor :
                          whiteColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.leadDetailsWithTileFilterModel.data![index].name}',
                                    style: nameTextStyle,
                                  ),

                                  PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert_outlined,
                                      size: 20,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuItem<String>>[
                                        PopupMenuItem<String>(
                                          child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Mark as Unread',
                                                  style: popupMenuTextStyle,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              enquiryProvider.updateEnquiryStatus(
                                                  data.leadDetailsWithTileFilterModel.data![index].id
                                              );
                                              enquiryProvider.getEnquiryLeadDetailsWithTileList(
                                                  _selectedFromDate != null
                                                      ?
                                                  '${DateFormat('yyyy-MM-dd').format(_selectedFromDate)}'
                                                      : formattedInitialdDate,
                                                  _selectedToDate != null ? '${DateFormat('yyyy-MM-dd').format(
                                                      _selectedToDate)}' : formattedDate,
                                                  '${data.leadDetailsWithTileFilterModel.data![index].category}'
                                              );
                                              getEnquiryCountMethod();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          height: 31,
                                        ),
                                      ];
                                    },
                                  )
                                ],
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 15,
                                    color: titleTextColor,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    '${data.leadDetailsWithTileFilterModel.data![index].email}',
                                    style: subTextTextStyle,
                                  )
                                ],
                              ),

                              const SizedBox(height: 5),
                              InkWell(
                                onTap: (){
                                  FlutterPhoneDirectCaller.callNumber('+91${data.leadDetailsWithTileFilterModel.data![index].phone}');
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_enabled,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      '+91 ${data.leadDetailsWithTileFilterModel.data![index].phone}',
                                      style: subTextTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 7),
              ],
            ),
          );
        }else if (state is Failure) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'No Enquiries',
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget allEnquiryWidget(){
    return ChangeNotifierProvider<EnquiryProvider>(
      create: (ctx){
        return enquiryProvider;
      },
      child: Consumer<EnquiryProvider>(builder: (ctx, data, _){
        var state = data.enquiryLeadDetailsLiveData().getValue();
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
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.enquiryLeadDetailsModel.data!.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0), topRight: Radius.circular(5.0)),
                      ),
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            20, 30, 20,
                            MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // name
                                Text('${data.enquiryLeadDetailsModel.data![index].name}',
                                  style: nameTextStyle,
                                ),
                                const SizedBox(height: 10),

                                // email
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      '${data.enquiryLeadDetailsModel.data![index].email}',
                                      style: subTextTextStyle,
                                    )
                                  ],
                                ),

                                const SizedBox(height: 7),

                                // contact number
                                InkWell(
                                  onTap: (){
                                    FlutterPhoneDirectCaller.callNumber('+91${data.enquiryLeadDetailsModel.data![index].phone}');
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_enabled,
                                        size: 15,
                                        color: titleTextColor,
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        '+91 ${data.enquiryLeadDetailsModel.data![index].phone}',
                                        style: subTextTextStyle,
                                      )
                                    ],
                                  ),
                                ),

                                //  Calendar
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),
                                    Text(
                                      formatDateFromAPI(
                                          '${data.enquiryLeadDetailsModel.data![index].date}'
                                      ),
                                      style: subTextTextStyle,
                                    ),

                                    const SizedBox(width: 15),

                                    const Icon(
                                      CupertinoIcons.arrow_down_left,
                                      size: 15,
                                      color: titleTextColor,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${data.enquiryLeadDetailsModel.data![index].category}',
                                      style: subTextTextStyle,
                                    ),
                                  ],
                                ),

                                // messages
                                const SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: const Icon(
                                        Icons.message_outlined,
                                        size: 15,
                                        color: titleTextColor,
                                      ),
                                    ),

                                    const SizedBox(width: 5),
                                    Expanded(
                                      child:
                                      '${data.enquiryLeadDetailsModel.data![index].message}' == "" ?
                                      Text(
                                        'No message',
                                        style: subTextTextStyle,
                                      ) :
                                      Text(
                                        '${data.enquiryLeadDetailsModel.data![index].message}',
                                        style: subTextTextStyle,
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 15),
                                Text(
                                  'Comments',
                                  style: noteHeadingTextStyle,
                                ),

                                const SizedBox(height: 10),

                                AddNotesWidget(
                                    '${data.enquiryLeadDetailsModel.data![index].id}'
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).then((value) {
                      enquiryProvider.updateEnquiryStatus(
                          data.enquiryLeadDetailsModel.data![index].id
                      );
                      getEnquiryCountMethod();
                    });
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                          data.enquiryLeadDetailsModel.data![index].status == false ?
                          highlightingColor :
                          whiteColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.enquiryLeadDetailsModel.data![index].name}',
                                    style: nameTextStyle,
                                  ),

                                  PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert_outlined,
                                      size: 20,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuItem<String>>[
                                        PopupMenuItem<String>(
                                          child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Mark as Unread',
                                                  style: popupMenuTextStyle,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              enquiryProvider.updateEnquiryStatus(
                                                  data.enquiryLeadDetailsModel.data![index].id
                                              );
                                              getEnquiryCountMethod();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          height: 31,
                                        ),
                                      ];
                                    },
                                  )
                                ],
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 15,
                                    color: titleTextColor,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    '${data.enquiryLeadDetailsModel.data![index].email}',
                                    style: subTextTextStyle,
                                  )
                                ],
                              ),

                              const SizedBox(height: 5),
                              InkWell(
                                onTap: (){
                                  FlutterPhoneDirectCaller.callNumber('+91${data.enquiryLeadDetailsModel.data![index].phone}');
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_enabled,
                                      size: 15,
                                      color: titleTextColor,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      '+91 ${data.enquiryLeadDetailsModel.data![index].phone}',
                                      style: subTextTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 7),
              ],
            ),
          );
        }else if (state is Failure) {
          return SizedBox();
        } else {
          return Container();
        }
      }),
    );
  }

  String formatDateFromAPI(String apiDate) {
    DateTime? date = DateTime.tryParse(apiDate);
    final formattedDate =
        DateFormat('d').format(date!) + '-' + DateFormat('MM').format(date) +'-' + DateFormat('y').format(date);
    return formattedDate;
  }

  bool filterApiCall = false;

  void filterModalSheet(BuildContext context){
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              child: FilterScreen(),
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        filterApiCall = true;
      });
      enquiryUiWidget();
      // getEnquiryCountMethod();
      // channelConnectProvider.getChannelConnectPost(widget.channelId);
      // This function is called when the modal sheet is dismissed
      print('Modal sheet dismissed');
      // Add your function here
    });
  }
}
