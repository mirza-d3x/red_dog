import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/auth/create_analytics_screen.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/tabView_page.dart';
import '../../styles/text_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

const List<String> scopes = <String>[
  'email',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> _handleSignIn() async{
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Navigate to the desired screen when the user is signed in
        print('#########################################################################33');
        print(googleSignInAccount.email);
        print(googleSignInAccount.displayName);
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    }

  dynamic _value = 'With Analytics';

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
                  'Website Monitor',
                  style: mediumTextStyle
                ),

                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Text(
                    'Essential tool for webmasters and business owners to understand website performance',
                    style: loginDescTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [

                        // with analytics
                        Container(
                          decoration: BoxDecoration(
                            color: _value == 'With Analytics' ?
                            redColor : whiteColor,
                            borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _value == 'With Analytics' ? redColor :
                                  unselectedRadioColor
                              )
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: 'With Analytics',
                                groupValue: _value ,
                                onChanged: (value){
                                  setState(() {
                                    _value = value;
                                  });
                                },
                                activeColor: whiteColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text(
                                  'With Analytics',
                                  style: _value == 'With Analytics' ?
                                      loginButtonTextStyle : loginInactiveRadioTextStyle
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // without analytics
                        Container(
                          decoration: BoxDecoration(
                            color: _value == 'With Analytics' ?
                            whiteColor : redColor,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _value == 'With Analytics' ?
                              unselectedRadioColor : redColor
                            )
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: 'Without Analytics',
                                groupValue: _value ,
                                onChanged: (value){
                                  setState(() {
                                    _value = value;
                                  });
                                },
                                activeColor: whiteColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text(
                                  'Without Analytics',
                                    style: _value == 'With Analytics' ?
                                     loginInactiveRadioTextStyle : loginButtonTextStyle
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                //  Continue with Google
                InkWell(
                  onTap: (){
                    _handleSignIn();
                    // _value == 'With Analytics' ?
                    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(true)))
                    //     : Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateAnalyticsScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        // color: whiteColor,
                        border: Border.all(
                            color: whiteColor
                        ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.only(top: 13,bottom: 13),
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/images/google.png',
                          height: 20,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Continue With Google',
                          style: loginButtonTextStyle
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Text(
                  'Terms of Service & Privacy Policy',
                  style: loginTermsTextStyle
                )
              ],
            ),
          ),
        )
    );
  }
}
