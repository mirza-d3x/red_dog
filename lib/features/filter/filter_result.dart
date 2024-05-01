import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';

import '../../core/ui_state.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../notes/add_notes_screen.dart';

class FilterResultScreen extends StatefulWidget {
  dynamic timeFrame;
  dynamic sortBy;
  dynamic readStatus;
   FilterResultScreen(this.timeFrame,this.sortBy,this.readStatus,{super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {

  EnquiryProvider enquiryProvider = EnquiryProvider(enquiryRepository: EnquiryRepository());

  @override
  void initState(){
    super.initState();
    enquiryProvider.getFilterList(widget.timeFrame, widget.sortBy, widget.readStatus);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: whiteColor,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: blackColor,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              'Filter',
              style: appBarTitleTextStyle,
            ),
          ),
          body: filterDataWidget(),
        )
    );
  }

  Widget filterDataWidget(){
    return ChangeNotifierProvider<EnquiryProvider>(
      create: (ctx){
        return enquiryProvider;
      },
      child: Consumer<EnquiryProvider>(builder: (ctx, data, _){
        var state = data.enquiryFilterLiveData().getValue();
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
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.filterModel.data!.length,
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
                                  Text('${data.filterModel.data![index].name}',
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
                                        '${data.filterModel.data![index].email}',
                                        style: subTextTextStyle,
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 7),

                                  // contact number
                                  InkWell(
                                    onTap: (){
                                      FlutterPhoneDirectCaller.callNumber('+91${data.filterModel.data![index].phone}');
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
                                          '+91 ${data.filterModel.data![index].phone}',
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
                                            '${data.filterModel.data![index].date}'
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
                                        '${data.filterModel.data![index].category}',
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
                                        '${data.filterModel.data![index].message}' == "" ?
                                        Text(
                                          'No message',
                                          style: subTextTextStyle,
                                        ) :
                                        Text(
                                          '${data.filterModel.data![index].message}',
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
                                      '${data.filterModel.data![index].id}'
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor,
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
                                      '${data.filterModel.data![index].name}',
                                      style: nameTextStyle,
                                    ),
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
                                      '${data.filterModel.data![index].email}',
                                      style: subTextTextStyle,
                                    )
                                  ],
                                ),

                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: (){
                                    FlutterPhoneDirectCaller.callNumber('+91${data.filterModel.data![index].phone}');
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
                                        '+91 ${data.filterModel.data![index].phone}',
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
            ),
          );
        }else if (state is Failure) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'No Data Found',
              ),
            ),
          );
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
}
