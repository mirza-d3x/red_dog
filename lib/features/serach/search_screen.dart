import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/providers/search_provider.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';

import '../../core/ui_state.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../notes/add_notes_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchKeywordController = TextEditingController();
  bool apiCall = false;

  SearchProvider searchProvider = SearchProvider(commonRepository: CommonRepository());

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
              'Search',
              style: appBarTitleTextStyle,
            ),
          ),
          body: Column(
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
                          setState(() {
                            searchProvider.fetchSearchList(searchKeywordController.text);
                            apiCall = true;
                          });
                          // searchProvider.fetchSearchList(searchKeywordController.text);
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
              ),

                // apiCall == false ? SizedBox() :
                // searchResultWidget()
              Expanded(
                child: SingleChildScrollView(
                  child: apiCall == false ? SizedBox() : searchResultWidget(),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget searchResultWidget() {
    return ChangeNotifierProvider<SearchProvider>(
      create: (ctx) {
        return searchProvider;
      },
      child: Consumer<SearchProvider>(builder: (ctx, data, _) {
        var state = data.searchListLiveData().getValue();
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
          return  Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: ListView.builder(
                itemCount: data.searchModel.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index) => Column(
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
                                    Text('${data.searchModel.data![index].name}',
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
                                          '${data.searchModel.data![index].email}',
                                          style: subTextTextStyle,
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 7),

                                    // contact number
                                    InkWell(
                                      onTap: (){
                                        FlutterPhoneDirectCaller.callNumber('+91${data.searchModel.data![index].phone}');
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
                                            '+91 ${data.searchModel.data![index].phone}',
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
                                              '${data.searchModel.data![index].date}'
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
                                          '${data.searchModel.data![index].category}',
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
                                          '${data.searchModel.data![index].message}' == "" ?
                                          Text(
                                            'No message',
                                            style: subTextTextStyle,
                                          ) :
                                          Text(
                                            '${data.searchModel.data![index].message}',
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
                                        '${data.searchModel.data![index].id}'
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
                                        '${data.searchModel.data![index].name}',
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
                                        '${data.searchModel.data![index].email}',
                                        style: subTextTextStyle,
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: (){
                                      FlutterPhoneDirectCaller.callNumber('+91${data.searchModel.data![index].phone}');
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
                                          '+91 ${data.searchModel.data![index].phone}',
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
        } else if (state is Failure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text(
                'No Data Foud',
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
