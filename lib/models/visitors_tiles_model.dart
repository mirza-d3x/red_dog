// To parse this JSON data, do
//
//     final visitorsTileDataModel = visitorsTileDataModelFromJson(jsonString);

import 'dart:convert';

VisitorsTileDataModel visitorsTileDataModelFromJson(String str) => VisitorsTileDataModel.fromJson(json.decode(str));

String visitorsTileDataModelToJson(VisitorsTileDataModel data) => json.encode(data.toJson());

class VisitorsTileDataModel {
  String ? visitors;
  String ? newVisitors;
  String ? bounceRate;
  String ? sessions;
  String ? avgSessionDuration;

  VisitorsTileDataModel({
     this.visitors,
     this.newVisitors,
     this.bounceRate,
     this.sessions,
     this.avgSessionDuration,
  });

  factory VisitorsTileDataModel.fromJson(Map<String, dynamic> json) => VisitorsTileDataModel(
    visitors: json["visitors"],
    newVisitors: json["newVisitors"],
    bounceRate: json["bounceRate"],
    sessions: json["sessions"],
    avgSessionDuration: json["avgSessionDuration"],
  );

  Map<String, dynamic> toJson() => {
    "visitors": visitors,
    "newVisitors": newVisitors,
    "bounceRate": bounceRate,
    "sessions": sessions,
    "avgSessionDuration": avgSessionDuration,
  };
}
