// To parse this JSON data, do
//
//     final trafficSourceModel = trafficSourceModelFromJson(jsonString);

import 'dart:convert';

TrafficSourceModel trafficSourceModelFromJson(String str) => TrafficSourceModel.fromJson(json.decode(str));

String trafficSourceModelToJson(TrafficSourceModel data) => json.encode(data.toJson());

class TrafficSourceModel {
  String ? message;
  int ? code;
  List<TrafficSourceData> ? data;

  TrafficSourceModel({
     this.message,
     this.code,
     this.data,
  });

  factory TrafficSourceModel.fromJson(Map<String, dynamic> json) => TrafficSourceModel(
    message: json["message"],
    code: json["code"],
    data: List<TrafficSourceData>.from(json["data"].map((x) => TrafficSourceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TrafficSourceData {
  String ? key;
  int ? value;

  TrafficSourceData({
     this.key,
     this.value,
  });

  factory TrafficSourceData.fromJson(Map<String, dynamic> json) => TrafficSourceData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
