import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/providers/forgot_password_provider.dart';
import 'package:reddog_mobile_app/repositories/auth_repository.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/text_field.dart';
import '../login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  dynamic email;
   ResetPasswordScreen(this.email,{super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  TextEditingController filed1 = TextEditingController();
  TextEditingController filed2 = TextEditingController();
  TextEditingController filed3 = TextEditingController();
  TextEditingController filed4 = TextEditingController();
  TextEditingController filed5 = TextEditingController();
  TextEditingController filed6 = TextEditingController();

  String otpErrorMessage = '';

  bool validateFiled1(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  bool validateFiled2(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  bool validateFiled3(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  bool validateFiled4(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  bool validateFiled5(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  bool validateFiled6(String value) {
    if ((value.isEmpty)) {
      setState(() {
        if(filed1.text.isEmpty){
          const snackBar = SnackBar(
            backgroundColor: whiteColor,
            content: SizedBox(
              height: 30,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please type complete OTP',style: TextStyle(color: blackColor),
                  )),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
        // otpErrorMessage = "Enter the OTP";
      });
      return false;
    } else {
      setState(() {
        otpErrorMessage = "";
      });
      return true;
    }
  }

  String passErrorMessage = "";
  bool validateNewPassword(String value) {
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
  String confirmPassErrorMessage = "";
  bool validateConfirmPassword(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        confirmPassErrorMessage = "Password can't be empty";
      });
      return false;
    } else {
      setState(() {
        confirmPassErrorMessage = "";
      });
      return true;
    }
  }

  bool isLoading = false;

  ForgotPasswordProvider forgotPasswordProvider = ForgotPasswordProvider(authRepository: AuthRepository());

  onButtonClick() async{
    final isValidField1 = validateFiled1(filed1.text);
    final isValidField2 = validateFiled2(filed2.text);
    final isValidField3 = validateFiled3(filed3.text);
    final isValidField4 = validateFiled4(filed4.text);
    final isValidField5 = validateFiled5(filed5.text);
    final isValidNewPassword = validateNewPassword(newPasswordController.text);
    final isValidConfirmPassword = validateConfirmPassword(confirmPasswordController.text);
    if(isValidField1 && isValidField2 && isValidField3 && isValidField4 && isValidField5) {
      setState(() {
        isLoading = true;
      });
      String newOtp = filed1.text + filed2.text + filed3.text + filed4.text +
          filed5.text;
      if (newOtp.isNotEmpty && isValidNewPassword && isValidConfirmPassword
          && newPasswordController.text == confirmPasswordController.text
      ) {
        await forgotPasswordProvider.updatePassword(
            widget.email,
            newOtp,
            newPasswordController.text,
        );
        if(forgotPasswordProvider.forgotPasswordModel.statusCode == 200){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }else{
          final snackBar = SnackBar(
            content: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Incorrect OTP',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
          setState(() {
            isLoading = false;
          });
        }
      }
      else{
        final snackBar = SnackBar(
          content: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Mismatch',
                    ),

                    const SizedBox(height: 5),
                    Expanded(
                      child: Text(
                        'New Password and Confirm Password must same',
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
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
                Text(
                    'OTP *',
                    style: labelBeforeTextStyle
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        otpTextFiledWidget(true,filed1),
                        otpTextFiledWidget(false,filed2),
                        otpTextFiledWidget(false,filed3),
                        otpTextFiledWidget(false,filed4),
                        otpTextFiledWidget(false,filed5),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'New Password *',
                  style: labelBeforeTextStyle,
                ),
                const SizedBox(height: 15),
                textFiled(setState,true,newPasswordController,passErrorMessage),

                const SizedBox(height: 15),
                Text(
                  'Confirm Password *',
                  style: labelBeforeTextStyle,
                ),
                const SizedBox(height: 15),
                textFiled(setState,true,confirmPasswordController,confirmPassErrorMessage),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () => onButtonClick(),
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
                                  'Submit',
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

  Widget otpTextFiledWidget(bool autoFocus,TextEditingController controller){
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: tileNumberColor,
        style: nameTextStyle,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 15,top: 2,bottom: 2),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: blackColor,
                // _getColor('blackColor')
              )
          ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //       color: _getColor('blackColor')
          //   ),
          // ),
          // errorText: otpErrorMessage,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: blackColor,
                // _getColor('blackColor')
              )
          ),
        ),
        onChanged: (value){
          if(value.length == 1){
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
