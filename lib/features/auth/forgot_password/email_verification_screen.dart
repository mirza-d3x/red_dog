import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/features/auth/forgot_password/reset_password_screen.dart';
import 'package:reddog_mobile_app/features/auth/login_screen.dart';
import 'package:reddog_mobile_app/providers/forgot_password_email_provider.dart';
import 'package:reddog_mobile_app/repositories/auth_repository.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/text_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final emailController = TextEditingController();
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

  bool isLoading = false;

  ForgotPasswordEmailProvider forgotPasswordEmailProvider = ForgotPasswordEmailProvider(authRepository: AuthRepository());

  onSubmit() async{
    final isValidEmail = validateEmail(emailController.text);
    if (isValidEmail) {
      setState(() {
        isLoading = true;
      });
      await forgotPasswordEmailProvider.checkForgotPasswordEmail(emailController.text);
      if(forgotPasswordEmailProvider.forgotPasswordEmailModel.statusCode == 200){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 340,
            content: Text(
                'Please enter the registered Email',
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
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
              'Forgot Password',
              style: appBarTitleTextStyle,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 40, 20, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/redDog_logo.png',
                    height: 25,
                  ),
                ),

                const SizedBox(height: 100),

                Text('Enter your email below to receive your password reset OTP',
                  style: noteTextStyle,
                  textDirection: TextDirection.ltr,
                ),

                const SizedBox(height: 30),
                Text(
                  'Email address *',
                  style: labelBeforeTextStyle,
                ),
                const SizedBox(height: 15),
                textFiled(setState,false,emailController,emailErrorMessage),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: isLoading == false ? 40 : 50,
                      child: TextButton(
                        onPressed: () => onSubmit(),
                        style: TextButton.styleFrom(
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                          foregroundColor: Colors.white,
                          backgroundColor: redColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child:
                          isLoading == true ?
                          Center(
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          ) :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Center(
                                child: Text(
                                  'Get OTP',
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
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
