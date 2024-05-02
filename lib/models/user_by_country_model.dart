// To parse this JSON data, do
//
//     final userByCountryModel = userByCountryModelFromJson(jsonString);

import 'dart:convert';

UserByCountryModel userByCountryModelFromJson(String str) => UserByCountryModel.fromJson(json.decode(str));

String userByCountryModelToJson(UserByCountryModel data) => json.encode(data.toJson());

class UserByCountryModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  UserByCountryModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByCountryModel.fromJson(Map<String, dynamic> json) => UserByCountryModel(
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
  dynamic name;
  int ? value;
  dynamic percentage;

  Datum({
     this.name,
     this.value,
     this.percentage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    value: json["value"],
    percentage: json["percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "percentage": percentage,
  };
}
