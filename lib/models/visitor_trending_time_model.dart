// To parse this JSON data, do
//
//     final visitorsTrendingTimeModel = visitorsTrendingTimeModelFromJson(jsonString);

import 'dart:convert';

VisitorsTrendingTimeModel visitorsTrendingTimeModelFromJson(String str) => VisitorsTrendingTimeModel.fromJson(json.decode(str));

String visitorsTrendingTimeModelToJson(VisitorsTrendingTimeModel data) => json.encode(data.toJson());

class VisitorsTrendingTimeModel {
  String ? message;
  int ? code;
  List<TrendingTimeData> ? data;

  VisitorsTrendingTimeModel({
     this.message,
     this.code,
     this.data,
  });

  factory VisitorsTrendingTimeModel.fromJson(Map<String, dynamic> json) => VisitorsTrendingTimeModel(
    message: json["message"],
    code: json["code"],
    data: List<TrendingTimeData>.from(json["data"].map((x) => TrendingTimeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TrendingTimeData {
  String ? date;
  String ? value;

  TrendingTimeData({
     this.date,
     this.value,
  });

  factory TrendingTimeData.fromJson(Map<String, dynamic> json) => TrendingTimeData(
    date: json["date"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "value": value,
  };
}
