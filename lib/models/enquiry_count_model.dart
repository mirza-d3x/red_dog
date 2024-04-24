// To parse this JSON data, do
//
//     final enquiryCountModel = enquiryCountModelFromJson(jsonString);

import 'dart:convert';

EnquiryCountModel enquiryCountModelFromJson(String str) => EnquiryCountModel.fromJson(json.decode(str));

String enquiryCountModelToJson(EnquiryCountModel data) => json.encode(data.toJson());

class EnquiryCountModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  EnquiryCountModel({
     this.message,
     this.code,
     this.data,
  });

  factory EnquiryCountModel.fromJson(Map<String, dynamic> json) => EnquiryCountModel(
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
  int ? count;
  String ? category;

  Datum({
     this.count,
     this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    count: json["count"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "category": category,
  };
}
