import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';

import '../styles/text_styles.dart';

AppBar commonAppBar(
    BuildContext context,String text,
    ) {
  return AppBar(
    elevation: 1,
    backgroundColor: whiteColor,
    automaticallyImplyLeading: true,
    titleSpacing: 20,
    title: Text(
      text,
      style: appBarTitleTextStyle,
    ),
  );
}