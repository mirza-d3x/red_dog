// To parse this JSON data, do
//
//     final updateReadStatusModel = updateReadStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateReadStatusModel updateReadStatusModelFromJson(String str) => UpdateReadStatusModel.fromJson(json.decode(str));

String updateReadStatusModelToJson(UpdateReadStatusModel data) => json.encode(data.toJson());

class UpdateReadStatusModel {
  String ? message;
  int ? code;

  UpdateReadStatusModel({
     this.message,
     this.code,
  });

  factory UpdateReadStatusModel.fromJson(Map<String, dynamic> json) => UpdateReadStatusModel(
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
