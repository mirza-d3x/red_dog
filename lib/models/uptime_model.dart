// To parse this JSON data, do
//
//     final uptimeModel = uptimeModelFromJson(jsonString);

import 'dart:convert';

UptimeModel uptimeModelFromJson(String str) => UptimeModel.fromJson(json.decode(str));

String uptimeModelToJson(UptimeModel data) => json.encode(data.toJson());

class UptimeModel {
  String ? message;
  int ? code;
  Data ? data;

  UptimeModel({
     this.message,
     this.code,
     this.data,
  });

  factory UptimeModel.fromJson(Map<String, dynamic> json) => UptimeModel(
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
  dynamic uptime;

  Data({
     this.uptime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uptime: json["uptime"],
  );

  Map<String, dynamic> toJson() => {
    "uptime": uptime,
  };
}
