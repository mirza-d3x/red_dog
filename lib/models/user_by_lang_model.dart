// To parse this JSON data, do
//
//     final userByLangModel = userByLangModelFromJson(jsonString);

import 'dart:convert';

UserByLangModel userByLangModelFromJson(String str) => UserByLangModel.fromJson(json.decode(str));

String userByLangModelToJson(UserByLangModel data) => json.encode(data.toJson());

class UserByLangModel {
  String ? message;
  int ? code;
  List<List<String>> ? data;

  UserByLangModel({
     this.message,
     this.code,
     this.data,
  });

  factory UserByLangModel.fromJson(Map<String, dynamic> json) => UserByLangModel(
    message: json["message"],
    code: json["code"],
    data: List<List<String>>.from(json["data"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
