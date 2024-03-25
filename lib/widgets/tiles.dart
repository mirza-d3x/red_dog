import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

import '../styles/text_styles.dart';

Widget tiles(String title,String number){
  return Card(
    elevation: 2,
    shadowColor: whiteColor,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           title,
            style: tileTitleTextStyle,
          ),

          const SizedBox(height: 8),
          Text(
            number,
            style: tileNumberTextStyle,
          )
        ],
      ),
    ),
  );
}