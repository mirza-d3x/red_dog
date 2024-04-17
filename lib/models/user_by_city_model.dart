// To parse this JSON data, do
//
//     final userByCityModel = userByCityModelFromJson(jsonString);

import 'dart:convert';

UserByCityModel userByCityModelFromJson(String str) => UserByCityModel.fromJson(json.decode(str));

String userByCityModelToJson(UserByCityModel data) => json.encode(data.toJson());

class UserByCityModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  UserByCityModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByCityModel.fromJson(Map<String, dynamic> json) => UserByCityModel(
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
  String ? name;
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
