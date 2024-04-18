// To parse this JSON data, do
//
//     final userByNewTurnedModel = userByNewTurnedModelFromJson(jsonString);

import 'dart:convert';

UserByNewTurnedModel userByNewTurnedModelFromJson(String str) => UserByNewTurnedModel.fromJson(json.decode(str));

String userByNewTurnedModelToJson(UserByNewTurnedModel data) => json.encode(data.toJson());

class UserByNewTurnedModel {
  String ? message;
  int ? code;
  List<NewReturnedData> ? data;

  UserByNewTurnedModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByNewTurnedModel.fromJson(Map<String, dynamic> json) => UserByNewTurnedModel(
    message: json["message"],
    code: json["code"],
    data: List<NewReturnedData>.from(json["data"].map((x) => NewReturnedData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NewReturnedData {
  String ? key;
  int ? value;

  NewReturnedData({
     this.key,
     this.value,
  });

  factory NewReturnedData.fromJson(Map<String, dynamic> json) => NewReturnedData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
