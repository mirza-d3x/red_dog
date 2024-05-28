import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/help_data_model.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  Future<List<HelpData>> loadHelpData() async {
    final String response = await rootBundle.loadString('assets/help_data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => HelpData.fromJson(json)).toList();
  }

  bool _customTileExpanded = false;

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
              'Help',
              style: appBarTitleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: FutureBuilder<List<HelpData>>(
              future: loadHelpData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  final helpData = snapshot.data!;
                  return ListView.builder(
                    itemCount: helpData.length,
                    itemBuilder: (context, index) {
                      final item = helpData[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 0.0),
                        child: ExpansionTile(
                          iconColor: blackColor,
                          collapsedIconColor: blackColor,
                          // childrenPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          title: Text(
                            item.title,
                            style: helpTitleTextStyle,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                              child: Text(
                                  item.description,
                                style: helpDescTextStyle,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
    );
  }
}
