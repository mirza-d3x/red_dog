// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  String ? code;
  String ? message;
  String ? status;
  UserDetails ? userDetails;

  UserProfileModel({
     this.code,
     this.message,
     this.status,
     this.userDetails,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    code: json["code"],
    message: json["message"],
    status: json["status"],
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "status": status,
    "userDetails": userDetails!.toJson(),
  };
}

class UserDetails {
  String ? googleId;
  String ? email;
  String ? name;
  String ? picture;
  bool ? isAnalytics;

  UserDetails({
     this.googleId,
     this.email,
     this.name,
     this.picture,
     this.isAnalytics,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    googleId: json["googleId"],
    email: json["email"],
    name: json["name"],
    picture: json["picture"],
    isAnalytics: json["isAnalytics"],
  );

  Map<String, dynamic> toJson() => {
    "googleId": googleId,
    "email": email,
    "name": name,
    "picture": picture,
    "isAnalytics": isAnalytics,
  };
}
