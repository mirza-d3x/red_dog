import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/tabView_page.dart';

import '../../styles/text_styles.dart';
import '../../widgets/text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  String passErrorMessage = "";

  bool validatePassword(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        passErrorMessage = "Password can't be empty";
      });
      return false;
    } else {
      setState(() {
        passErrorMessage = "";
      });
      return true;
    }
  }

  String emailErrorMessage = "";

  bool validateEmail(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        emailErrorMessage = "Email can't be empty";
      });
      return false;
    } else {
      setState(() {
        emailErrorMessage = "";
      });
      return true;
    }
  }

  onLogin() async{
    final isValidEmail = validateEmail(emailController.text);
    final isValidPassword = validatePassword(passwordController.text);
    if (isValidEmail && isValidPassword) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabViewScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body:  Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/redDog_logo.png',
                    height: 25,
                  ),
                ),

                const SizedBox(height: 50),
                Center(
                  child: Text(
                    'Login',
                    style:
                    signInTitleTextStyle,
                  ),
                ),


                const SizedBox(height: 30),
                Text(
                  'Email address *',
                  style: labelBeforeTextStyle,
                ),
                const SizedBox(height: 15),
                textFiled(setState,false,emailController,emailErrorMessage),

                const SizedBox(height: 10),
                Text(
                    'Password *',
                    style: labelBeforeTextStyle
                ),
                const SizedBox(height: 15),
                textFiled(setState,true,passwordController,passErrorMessage),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () => onLogin(),
                        style: TextButton.styleFrom(
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                          foregroundColor: Colors.white,
                          backgroundColor: redColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            children:  [
                              Center(
                                child: Text(
                                  'Login',
                                  style: loginButtonTextStyle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.arrow_forward_outlined,
                                color: whiteColor,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget buildPasswordTextField(String hintText) {
    return  TextField(
      cursorColor: blackColor,
      onChanged: (_) => setState(() {}),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 15,top: 2,bottom: 2),
        fillColor: whiteColor,
        filled: true,
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: textFieldBorderColorColor),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
        errorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
        ),
      ),
    );
  }
}
