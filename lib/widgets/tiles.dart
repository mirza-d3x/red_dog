import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import '../styles/text_styles.dart';

Widget tiles(BuildContext context,String title,String number){
  return Card(
    elevation: 2,
    shadowColor: whiteColor,
    child: Container(
      width: MediaQuery.of(context).size.width / 2.3,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           '${toBeginningOfSentenceCase(title)}',
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