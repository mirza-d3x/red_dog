import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/common_button.dart';
import 'package:reddog_mobile_app/widgets/text_field.dart';

import '../../styles/text_styles.dart';
import '../../tabView_page.dart';

class CreateAnalyticsScreen extends StatefulWidget {
  const CreateAnalyticsScreen({super.key});

  @override
  State<CreateAnalyticsScreen> createState() => _CreateAnalyticsScreenState();
}

class _CreateAnalyticsScreenState extends State<CreateAnalyticsScreen> {

  TextEditingController websiteNameController = TextEditingController();
  TextEditingController urlNameController = TextEditingController();

  String websiteErrorMessage = "";
  bool validateWebsiteName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        websiteErrorMessage = "Enter your Website Name";
      });
      return false;
    } else {
      setState(() {
        websiteErrorMessage = "";
      });
      return true;
    }
  }

  String urlErrorMessage = "";
  bool validateUrl(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        urlErrorMessage = "Enter the URL";
      });
      return false;
    } else {
      setState(() {
        urlErrorMessage = "";
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: loginBgColor,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/redDog_logo.png',
                  height: 35,
                ),

                const SizedBox(height: 40),

                Text(
                  'Create Your First Analytics',
                  style: normalHeadTextStyle
                ),
                
                const SizedBox(height: 30),
                textFiled(setState,'Website Name', websiteNameController,websiteErrorMessage),
                // const SizedBox(height: 5),
                textFiled(setState,'URL', urlNameController,urlErrorMessage),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: textButton(context, 'Submit',onSubmit),
                    )
                  ],
                ),

                const SizedBox(height: 60),
                Text(
                  'Terms of Service & Privacy Policy',
                  style: privacyTextStyle
                )
              ],
            ),
          ),
        )
    );
  }

  onSubmit(){
    final isValidWebsiteName = validateWebsiteName(websiteNameController.text);
    final isValidUrl = validateUrl(urlNameController.text);
    if(isValidWebsiteName && isValidUrl){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(false)));
    }
  }
}
