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
                          title: Text(
                            item.title,
                            style: helpTitleTextStyle,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 5),
                              child: RichText(
                                text: _buildRichText(item.description),
                                textAlign: TextAlign.justify,
                              )
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


  TextSpan _buildRichText(String text) {
    List<TextSpan> spans = [];
    RegExp regExp = RegExp(r"\*\*(.*?)\*\*");
    Iterable<Match> matches = regExp.allMatches(text);

    int start = 0;
    for (Match match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontFamily: 'Barlow-SemiBold',
            // fontWeight: FontWeight.bold,
          color: blackColor,
          fontSize: 16
        ),
      ));
      start = match.end;
    }
    if (start < text.length) {
      String segment = text.substring(start).replaceAll(RegExp(r'\s+'), ' ').trim(); // Replace multiple spaces with a single space
      if (segment.isNotEmpty) {
        spans.add(TextSpan(text: segment));
      }
      // spans.add(TextSpan(text: text.substring(start)));
    }

    return TextSpan(
      children: spans,
      style: helpDescTextStyle,
    );
  }
}
