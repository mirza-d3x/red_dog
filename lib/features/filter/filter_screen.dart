import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.all(15),
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
                          Navigator.pop(context);
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
}
