// To parse this JSON data, do
//
//     final userByAgeGroupModel = userByAgeGroupModelFromJson(jsonString);

import 'dart:convert';

UserByAgeGroupModel userByAgeGroupModelFromJson(String str) => UserByAgeGroupModel.fromJson(json.decode(str));

String userByAgeGroupModelToJson(UserByAgeGroupModel data) => json.encode(data.toJson());

class UserByAgeGroupModel {
  String ? message;
  int ? code;
  dynamic data;

  UserByAgeGroupModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByAgeGroupModel.fromJson(Map<String, dynamic> json) => UserByAgeGroupModel(
    message: json["message"],
    code: json["code"],
    data: List<AgeData>.from(json["data"].map((x) => AgeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AgeData {
  dynamic key;
  dynamic value;

  AgeData({
     this.key,
     this.value,
  });

  factory AgeData.fromJson(Map<String, dynamic> json) => AgeData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
