// To parse this JSON data, do
//
//     final userByGenderModel = userByGenderModelFromJson(jsonString);

import 'dart:convert';

UserByGenderModel userByGenderModelFromJson(String str) => UserByGenderModel.fromJson(json.decode(str));

String userByGenderModelToJson(UserByGenderModel data) => json.encode(data.toJson());

class UserByGenderModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  UserByGenderModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByGenderModel.fromJson(Map<String, dynamic> json) => UserByGenderModel(
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
