// To parse this JSON data, do
//
//     final userByLangModel = userByLangModelFromJson(jsonString);

import 'dart:convert';

UserByLangModel userByLangModelFromJson(String str) => UserByLangModel.fromJson(json.decode(str));

String userByLangModelToJson(UserByLangModel data) => json.encode(data.toJson());

class UserByLangModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  UserByLangModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByLangModel.fromJson(Map<String, dynamic> json) => UserByLangModel(
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
  String ? language;
  String ? usercount;
  dynamic percentage;

  Datum({
     this.language,
     this.usercount,
     this.percentage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    language: json["language"],
    usercount: json["usercount"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "usercount": usercount,
    "percentage": percentage,
  };
}
