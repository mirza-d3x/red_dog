import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/ui_state.dart';
import '../../providers/registered_website_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../repositories/common_repository.dart';
import '../../repositories/user_repository.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import '../../utilities/shared_prefernces.dart';
import '../auth/login_screen.dart';
import '../common/notification_list_screen.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {

  UserProfileProvider userProfileProvider = UserProfileProvider(userRepository: UserRepository());

  RegisteredWebsiteProvider registeredWebsiteProvider = RegisteredWebsiteProvider(commonRepository: CommonRepository());

  @override
  void initState(){
    super.initState();
    userProfileProvider.getProfile();
    registeredWebsiteProvider.getRegisteredWebsiteList();
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
      });
    }
  }


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
          body: visitorsUiBasedOnAnalytics(),
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
                            deleteValue('token');
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            });
                            // UpdateAddress(data.list[index]);
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
                        value: selectedWebsite,
                        onChanged: (newValue) {
                          deleteValue('websiteId');
                          setState(() {
                            isSelectedFromDropDwn = true;
                            selectedWebsite = newValue;
                            setValue('websiteId', websiteViewId);
                          });
                        },
                        items: data.websiteListModel.data!.map((e) {
                          websiteName = e.name;
                          websiteViewId = e.datumId;
                          setValue('websiteId', websiteViewId);
                          return DropdownMenuItem(
                            // value: valueItem,
                            child: Text(e.name),
                            value: e.name,
                          );
                        },
                        ).toList(),
                      ),
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

}
