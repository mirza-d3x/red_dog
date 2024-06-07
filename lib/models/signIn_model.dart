// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  String ? code;
  String ? token;
  String ? isAnalytic;
  String ? message;
  String ? status;
  List<String> ? name;
  List<String> ? ids;
  List<String> ? websiteUrl;
  bool ? isRegistered;
  UserData ? userData;

  SignInModel({
     this.code,
     this.token,
     this.isAnalytic,
     this.message,
     this.status,
     this.name,
     this.ids,
     this.websiteUrl,
     this.isRegistered,
     this.userData,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    code: json["code"],
    token: json["token"],
    isAnalytic: json["isAnalytic"],
    message: json["message"],
    status: json["status"],
    name: List<String>.from(json["name"].map((x) => x)),
    ids: List<String>.from(json["ids"].map((x) => x)),
    websiteUrl: List<String>.from(json["websiteUrl"].map((x) => x)),
    isRegistered: json["is_registered"],
    userData: UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "token": token,
    "isAnalytic": isAnalytic,
    "message": message,
    "status": status,
    "name": List<dynamic>.from(name!.map((x) => x)),
    "ids": List<dynamic>.from(ids!.map((x) => x)),
    "websiteUrl": List<dynamic>.from(websiteUrl!.map((x) => x)),
    "is_registered": isRegistered,
    "userData": userData!.toJson(),
  };
}

class UserData {
  String ? googleId;
  String ? email;
  String ? name;
  String ? picture;
  String ? jToken;

  UserData({
     this.googleId,
     this.email,
     this.name,
     this.picture,
     this.jToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    googleId: json["googleId"],
    email: json["email"],
    name: json["name"],
    picture: json["picture"],
    jToken: json["jToken"],
  );

  Map<String, dynamic> toJson() => {
    "googleId": googleId,
    "email": email,
    "name": name,
    "picture": picture,
    "jToken": jToken,
  };
}
