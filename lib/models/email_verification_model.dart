// To parse this JSON data, do
//
//     final emailVerificationModel = emailVerificationModelFromJson(jsonString);

import 'dart:convert';

EmailVerificationModel emailVerificationModelFromJson(String str) => EmailVerificationModel.fromJson(json.decode(str));

String emailVerificationModelToJson(EmailVerificationModel data) => json.encode(data.toJson());

class EmailVerificationModel {
  int ? statusCode;
  String ? status;
  String ? message;
  Data ? data;

  EmailVerificationModel({
     this.statusCode,
     this.status,
     this.message,
     this.data,
  });

  factory EmailVerificationModel.fromJson(Map<String, dynamic> json) => EmailVerificationModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  String ? email;

  Data({
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
