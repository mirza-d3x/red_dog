import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/styles/colors.dart';
import 'package:reddog_mobile_app/widgets/tiles.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  tiles('VISITORS', '140'),

                  const SizedBox(height: 8),
                  tiles('NEW VISITORS', '132'),

                  const SizedBox(height: 8),
                  tiles('BOUNCE RATE', '61.75%'),

                  const SizedBox(height: 8),
                  tiles('SESSIONS', '183'),

                  const SizedBox(height: 8),
                  tiles('AVG SESSION DURATION', '106.46 S'),
                ],
              )

            ),
          ),
        )
    );
  }
}
