import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/auth/create_analytics_screen.dart';
import 'package:reddog_mobile_app/providers/registered_website_provider.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/tabView_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/login_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../../styles/text_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../utilities/api_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utilities/shared_prefernces.dart';
import 'dart:io' show Platform;

final FirebaseAuth _auth = FirebaseAuth.instance;
const List<String> scopes = <String>[
  'email',
  'profile',
  'https://www.googleapis.com/auth/analytics.readonly',
  'https://www.googleapis.com/auth/analytics.manage.users'
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

  LoginProvider loginProvider = LoginProvider(authRepository: AuthRepository());
  UserProfileProvider userProfileProvider = UserProfileProvider(userRepository: UserRepository());
  RegisteredWebsiteProvider registeredWebsiteProvider= RegisteredWebsiteProvider(commonRepository: CommonRepository());

  bool isLoading = false;
  bool isLoadingAppleLogin = false;

  Future<void> _handleSignIn() async {
    String token = await getFireBaseToken();
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      // print(googleSignInAccount!.authentication);
      if (googleSignInAccount != null) {
        setState(() {
          isLoading = true;
        });
        // Navigate to the desired screen when the user is signed in
        print(googleSignInAccount.email);
        print(googleSignInAccount.displayName);
        print(googleSignInAccount);
        dynamic FaccessToken = await googleSignInAccount.authentication.then((auth) => auth.accessToken);
        dynamic refreshToken = await googleSignInAccount.authentication.then((auth) => auth.idToken);
        print(FaccessToken);
        print(refreshToken);

        GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print(googleAuth.accessToken);
        print(googleAuth.idToken);

        UserCredential authResult = await _auth.signInWithCredential(credential);
        User? user = authResult.user;
        setValue('googleToken', googleAuth.accessToken);
        await loginProvider.checkLogin(
            googleSignInAccount.email,
            token.toString(),
            googleAuth.accessToken,
            // "false"
            _value == 'With Analytics' ? "true" : "false"
        );
        if(loginProvider.loginModel.status == 'success'){
          print('ffffffffffffffffffffffffffffffff');
          print(googleAuth.accessToken);
          // await userDetailProvider.fetchUserDetails();
          await userProfileProvider.getProfile();
          await registeredWebsiteProvider.getRegisteredWebsiteList();
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabViewScreen()));
          });
        }
        else{
          print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
          print(googleAuth.accessToken);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: whiteColor,
              behavior: SnackBarBehavior.floating,
              width: 340,
              content: Text(
                'Please select the registered Email',
                  // '${loginProvider.loginModel.message}',
                style: errorTextStyle
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
          _googleSignIn.signOut();
        }
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabViewPage()));
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  dynamic _value = 'With Analytics';

  @override
  void initState(){
    super.initState();
    _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: loginWhiteBgColor,
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
                  child: Card(
                    elevation: 3,
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
                ),

                const SizedBox(height: 25),
                //  Continue with Google
                InkWell(
                  onTap: (){
                    _handleSignIn();
                    // _value == 'With Analytics' ?
                    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(true)));
                    //     : Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateAnalyticsScreen()));
                  },
                  child: Container(
                    // height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // color: whiteColor,
                        border: Border.all(
                            color: loginDescColor
                        ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.only(top: 13,bottom: 13),
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    child:
                    isLoading == false ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/images/google.png',
                          height: 20,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Continue With Google',
                          style: continueWithGoogleButtonTextStyle
                        )
                      ],
                    )
                        :
                    Center(
                      child: CircularProgressIndicator(
                        color: loginBgColor,
                      ),
                    ),
                  ),
                ),

                Platform.isAndroid ? SizedBox() :
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    // height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: whiteColor,
                      border: Border.all(
                          color: loginDescColor
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.only(top: 13,bottom: 13),
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    child:
                    isLoadingAppleLogin == false ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/apple_logo.png',
                          height: 20,
                        ),

                        const SizedBox(width: 10),

                        Text(
                            'SigIn With Apple',
                            style: continueWithGoogleButtonTextStyle
                        )
                      ],
                    )
                        :
                    Center(
                      child: CircularProgressIndicator(
                        color: loginBgColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                InkWell(
                  onTap: (){
                    launch('https://app.reddog.live/account/terms-service');
                  },
                  child: Text(
                    'Terms of Service & Privacy Policy',
                    style: termsAndConditionTextStyle
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
