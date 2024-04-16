// To parse this JSON data, do
//
//     final visitorsTileDataModel = visitorsTileDataModelFromJson(jsonString);

import 'dart:convert';

VisitorsTileDataModel visitorsTileDataModelFromJson(String str) => VisitorsTileDataModel.fromJson(json.decode(str));

String visitorsTileDataModelToJson(VisitorsTileDataModel data) => json.encode(data.toJson());

class VisitorsTileDataModel {
  String ? message;
  int ? code;
  Data ? data;

  VisitorsTileDataModel({
     this.message,
     this.code,
     this.data,
  });

  factory VisitorsTileDataModel.fromJson(Map<String, dynamic> json) => VisitorsTileDataModel(
    message: json["message"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data!.toJson(),
  };
}

class Data {
  String ? visitors;
  String ? newVisitors;
  String ? bounceRate;
  String ? sessions;
  String ? avgSessionDuration;

  Data({
     this.visitors,
     this.newVisitors,
     this.bounceRate,
     this.sessions,
     this.avgSessionDuration,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
