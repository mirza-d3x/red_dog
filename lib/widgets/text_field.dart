import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';
Widget textFiled(StateSetter setState,bool isHiddenText,TextEditingController controller,String errorText){
  return TextField(
    style: textFieldTextStyle,
    obscureText: isHiddenText,
    controller: controller,
    cursorColor: blackColor,
    onChanged: (_) => setState((){}),
    decoration:  InputDecoration(
      contentPadding: const EdgeInsets.only(left: 15,top: 2,bottom: 2),
      fillColor: whiteColor,
      filled: true,
      errorText: controller.text == '' ? errorText : '',
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: textFieldBorderColorColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: appColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: textFieldBorderColorColor),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: appColor),
      ),
    ),
  );
}