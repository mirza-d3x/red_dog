// To parse this JSON data, do
//
//     final sslHealthModel = sslHealthModelFromJson(jsonString);

import 'dart:convert';

SslHealthModel sslHealthModelFromJson(String str) => SslHealthModel.fromJson(json.decode(str));

String sslHealthModelToJson(SslHealthModel data) => json.encode(data.toJson());

class SslHealthModel {
  String ? message;
  int ? code;
  String ? data;

  SslHealthModel({
     this.message,
     this.code,
     this.data,
  });

  factory SslHealthModel.fromJson(Map<String, dynamic> json) => SslHealthModel(
    message: json["message"],
    code: json["code"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data,
  };
}
