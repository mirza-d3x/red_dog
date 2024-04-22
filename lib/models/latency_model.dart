// To parse this JSON data, do
//
//     final latencyModel = latencyModelFromJson(jsonString);

import 'dart:convert';

LatencyModel latencyModelFromJson(String str) => LatencyModel.fromJson(json.decode(str));

String latencyModelToJson(LatencyModel data) => json.encode(data.toJson());

class LatencyModel {
  String ? message;
  int ? code;
  Data ? data;

  LatencyModel({
     this.message,
     this.code,
     this.data,
  });

  factory LatencyModel.fromJson(Map<String, dynamic> json) => LatencyModel(
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
  int ? latency;

  Data({
     this.latency,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    latency: json["latency"],
  );

  Map<String, dynamic> toJson() => {
    "latency": latency,
  };
}
