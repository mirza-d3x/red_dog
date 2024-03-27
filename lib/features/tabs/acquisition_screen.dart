import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/widgets/common_app_bar.dart';

class AcquisitionScreen extends StatefulWidget {
  const AcquisitionScreen({super.key});

  @override
  State<AcquisitionScreen> createState() => _AcquisitionScreenState();
}

class _AcquisitionScreenState extends State<AcquisitionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar(context, 'Acquisition'),
        )
    );
  }
}
