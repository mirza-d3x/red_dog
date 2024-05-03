// To parse this JSON data, do
//
//     final trafficSourceByDateModel = trafficSourceByDateModelFromJson(jsonString);

import 'dart:convert';

TrafficSourceByDateModel trafficSourceByDateModelFromJson(String str) => TrafficSourceByDateModel.fromJson(json.decode(str));

String trafficSourceByDateModelToJson(TrafficSourceByDateModel data) => json.encode(data.toJson());

class TrafficSourceByDateModel {
  String ? message;
  int ? code;
  List<TrafficSourceByDateModelDatum> ? data;

  TrafficSourceByDateModel({
     this.message,
     this.code,
     this.data,
  });

  factory TrafficSourceByDateModel.fromJson(Map<String, dynamic> json) => TrafficSourceByDateModel(
    message: json["message"],
    code: json["code"],
    data: List<TrafficSourceByDateModelDatum>.from(json["data"].map((x) => TrafficSourceByDateModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TrafficSourceByDateModelDatum {
  String ? name;
  List<TrafficDataByDate> ? data;

  TrafficSourceByDateModelDatum({
     this.name,
     this.data,
  });

  factory TrafficSourceByDateModelDatum.fromJson(Map<String, dynamic> json) => TrafficSourceByDateModelDatum(
    name: json["name"],
    data: List<TrafficDataByDate>.from(json["data"].map((x) => TrafficDataByDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TrafficDataByDate {
  String key;
  dynamic value;

  TrafficDataByDate({
    required this.key,
    required this.value,
  });

  factory TrafficDataByDate.fromJson(Map<String, dynamic> json) => TrafficDataByDate(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
