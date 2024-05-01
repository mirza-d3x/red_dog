import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/features/filter/filter_result.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';

import '../../core/ui_state.dart';
import '../../models/checkbox_model.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final checkBoxListItems = <CheckboxModel>[];

  EnquiryProvider enquiryProvider = EnquiryProvider(enquiryRepository: EnquiryRepository());

  @override
  void initState(){
    super.initState();
    checkBoxListItems.add(CheckboxModel(checkName: 'Monthly'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Weekly'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Yearly'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Newest First'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Oldest First'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Read'));
    checkBoxListItems.add(CheckboxModel(checkName: 'Unread'));
  }

  dynamic selectedOpt;

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
           body: Padding(
             padding: const EdgeInsets.only(right: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 ListView.builder(
                     physics: AlwaysScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: checkBoxListItems.length,
                     itemBuilder: (context,index){
                       return CheckboxListTile(
                         controlAffinity: ListTileControlAffinity.leading,
                         activeColor: loginBgColor,
                         title: Text(checkBoxListItems[index].checkName!,
                             style: notificationTextStyle
                         ),
                         value: checkBoxListItems[index].value,
                         onChanged: (value) {
                           setState(() {
                             checkBoxListItems[index].value = value!;
                             selectedOpt = checkBoxListItems[index].checkName!;
                           });
                         },
                       );
                     }
                 ),

                 const SizedBox(height: 15),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Container(
                       height: 40,
                       width: 100,
                       child: TextButton(
                         onPressed: (){
                           // Navigator.pop(context);
                           Navigator.push(context, MaterialPageRoute(builder: (_) => FilterResultScreen(
                               selectedOpt == "Monthly" ? 'monthly'
                                   : selectedOpt == "Weekly" ? 'weekly'
                                   : selectedOpt == "Yearly" ? 'yearly'
                                   : '',
                               selectedOpt == "Oldest First" ? 'oldest'
                                   : selectedOpt == "Newest First" ? 'newest' : '',
                               selectedOpt == "Read" ? true
                                   : selectedOpt == "Unread" ? false
                                   : true
                           )));
                         },
                         child: Center(
                           child: Text('Apply',
                               style: loginTermsTextStyle
                           ),
                         ),
                       ),
                       decoration: BoxDecoration(
                         color: loginBgColor,
                         border: Border.all(color: blackColor),
                         borderRadius: BorderRadius.circular(5),
                       ),
                     ),
                   ],
                 )
               ],
             ),
           ),
        ),
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
          return Text('vdbhv');
        }else if (state is Failure) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'No opt selected',
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
