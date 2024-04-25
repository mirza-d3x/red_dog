// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  String ? code;
  String ? message;
  Data ? data;

  LogoutModel({
     this.code,
     this.message,
     this.data,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  bool ? isRegistered;
  String ? id;
  List<Property> ? properties;
  String ? googleId;
  String ? userName;
  dynamic email;
  String ? profilePicture;
  String ? accessToken;
  String ? refreshToken;
  int ? mobileNumber;
  int ? v;
  String ? firId;
  List<Firebase> ? firebase;

  Data({
     this.isRegistered,
     this.id,
     this.properties,
     this.googleId,
     this.userName,
     this.email,
     this.profilePicture,
     this.accessToken,
     this.refreshToken,
     this.mobileNumber,
     this.v,
     this.firId,
     this.firebase,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isRegistered: json["is_registered"],
    id: json["_id"],
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
    googleId: json["googleId"],
    userName: json["userName"],
    email: json["email"],
    profilePicture: json["profilePicture"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    mobileNumber: json["mobileNumber"],
    v: json["__v"],
    firId: json["firId"],
    firebase: List<Firebase>.from(json["firebase"].map((x) => Firebase.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_registered": isRegistered,
    "_id": id,
    "properties": List<dynamic>.from(properties!.map((x) => x.toJson())),
    "googleId": googleId,
    "userName": userName,
    "email": email,
    "profilePicture": profilePicture,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "mobileNumber": mobileNumber,
    "__v": v,
    "firId": firId,
    "firebase": List<dynamic>.from(firebase!.map((x) => x.toJson())),
  };
}

class Firebase {
  String ? id;
  String ? token;

  Firebase({
    this.id,
     this.token,
  });

  factory Firebase.fromJson(Map<String, dynamic> json) => Firebase(
    id: json["_id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "token": token,
  };
}

class Property {
  bool ? isRegistered;
  bool ? isAnalytics;
  String ? moniterIntervel;
  bool ? caseInsensitive;
  String ? id;
  String ? propertyId;
  String ? name;
  String ? url;
  List<EmailElement> ? email;
  String ? keyword;

  Property({
     this.isRegistered,
     this.isAnalytics,
    this.moniterIntervel,
     this.caseInsensitive,
     this.id,
     this.propertyId,
     this.name,
     this.url,
     this.email,
    this.keyword,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    isRegistered: json["is_registered"],
    isAnalytics: json["is_analytics"],
    moniterIntervel: json["moniterIntervel"],
    caseInsensitive: json["caseInsensitive"],
    id: json["_id"],
    propertyId: json["id"],
    name: json["name"],
    url: json["url"],
    email: List<EmailElement>.from(json["email"].map((x) => EmailElement.fromJson(x))),
    keyword: json["keyword"],
  );

  Map<String, dynamic> toJson() => {
    "is_registered": isRegistered,
    "is_analytics": isAnalytics,
    "moniterIntervel": moniterIntervel,
    "caseInsensitive": caseInsensitive,
    "_id": id,
    "id": propertyId,
    "name": name,
    "url": url,
    "email": List<dynamic>.from(email!.map((x) => x.toJson())),
    "keyword": keyword,
  };
}

class EmailElement {
  bool ? isEnabled;
  String ? id;
  dynamic mailId;

  EmailElement({
     this.isEnabled,
     this.id,
     this.mailId,
  });

  factory EmailElement.fromJson(Map<String, dynamic> json) => EmailElement(
    isEnabled: json["is_enabled"],
    id: json["_id"],
    mailId: json["mailId"],
  );

  Map<String, dynamic> toJson() => {
    "is_enabled": isEnabled,
    "_id": id,
    "mailId": mailId,
  };
}
