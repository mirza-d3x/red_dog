// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

import '../styles/text_styles.dart';


Widget textButton(BuildContext context, String buttonText,Function callbackAction) {
  return InkWell(
    onTap: () => callbackAction(),
    child: SizedBox(
      height: 40,
      // width: 45,
      child: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Align(
          child: Text(
            buttonText,
            style: buttonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
