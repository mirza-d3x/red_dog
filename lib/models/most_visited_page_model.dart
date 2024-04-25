// To parse this JSON data, do
//
//     final mostVisitedPageModel = mostVisitedPageModelFromJson(jsonString);

import 'dart:convert';

MostVisitedPageModel mostVisitedPageModelFromJson(String str) => MostVisitedPageModel.fromJson(json.decode(str));

String mostVisitedPageModelToJson(MostVisitedPageModel data) => json.encode(data.toJson());

class MostVisitedPageModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  MostVisitedPageModel({
     this.message,
     this.code,
     this.data,
  });

  factory MostVisitedPageModel.fromJson(Map<String, dynamic> json) => MostVisitedPageModel(
    message: json["message"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String ? key;
  int ? value;

  Datum({
     this.key,
     this.value,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
