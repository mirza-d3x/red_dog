import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';
Widget textFiled(StateSetter setState,String _hintText,TextEditingController _controller){
  return Padding(
    padding: const EdgeInsets.only(left: 25,right: 25),
    child: TextField(
      style: textFieldTextStyle,
      controller: _controller,
      cursorColor: blackColor,
      onChanged: (_) => setState((){}),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15,top: 2,bottom: 2),
        fillColor: whiteColor,
        filled: true,
        hintText: _hintText,
        hintStyle: hintTextStyle,
        // errorText: _controller.text == '' ? _errorText : '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: whiteColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: whiteColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: whiteColor),
        ),
      ),
    ),
  );
}