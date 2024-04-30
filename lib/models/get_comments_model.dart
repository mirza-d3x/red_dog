// To parse this JSON data, do
//
//     final getCommentsModel = getCommentsModelFromJson(jsonString);

import 'dart:convert';

GetCommentsModel getCommentsModelFromJson(String str) => GetCommentsModel.fromJson(json.decode(str));

String getCommentsModelToJson(GetCommentsModel data) => json.encode(data.toJson());

class GetCommentsModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  GetCommentsModel({
     this.message,
     this.code,
     this.data,
  });

  factory GetCommentsModel.fromJson(Map<String, dynamic> json) => GetCommentsModel(
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
  String ? id;
  String ? message;
  DateTime ? createdDate;
  DateTime ? updatedDate;

  Datum({
     this.id,
     this.message,
     this.createdDate,
     this.updatedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    message: json["message"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "created_date": createdDate!.toIso8601String(),
    "updated_date": updatedDate!.toIso8601String(),
  };
}
