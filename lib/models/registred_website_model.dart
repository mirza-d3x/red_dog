// To parse this JSON data, do
//
//     final registeredWebsiteModel = registeredWebsiteModelFromJson(jsonString);

import 'dart:convert';

RegisteredWebsiteModel registeredWebsiteModelFromJson(String str) => RegisteredWebsiteModel.fromJson(json.decode(str));

String registeredWebsiteModelToJson(RegisteredWebsiteModel data) => json.encode(data.toJson());

class RegisteredWebsiteModel {
  String ? code;
  String ? message;
  String ? status;
  UserData ? userData;
  List<Datum> ? data;

  RegisteredWebsiteModel({
     this.code,
     this.message,
     this.status,
     this.userData,
     this.data,
  });

  factory RegisteredWebsiteModel.fromJson(Map<String, dynamic> json) => RegisteredWebsiteModel(
    code: json["code"],
    message: json["message"],
    status: json["status"],
    userData: UserData.fromJson(json["userData"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "status": status,
    "userData": userData!.toJson(),
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  bool ? isRegistered;
  bool ? isAnalytics;
  dynamic  moniterIntervel;
  bool ? caseInsensitive;
  dynamic  id;
  dynamic datumId;
  dynamic name;
  dynamic url;
  List<Email> ? email;
  dynamic keyword;

  Datum({
     this.isRegistered,
     this.isAnalytics,
     this.moniterIntervel,
     this.caseInsensitive,
     this.id,
     this.datumId,
     this.name,
     this.url,
     this.email,
    this.keyword,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    isRegistered: json["is_registered"],
    isAnalytics: json["is_analytics"],
    moniterIntervel: json["moniterIntervel"],
    caseInsensitive: json["caseInsensitive"],
    id: json["_id"],
    datumId: json["id"],
    name: json["name"],
    url: json["url"],
    email: List<Email>.from(json["email"].map((x) => Email.fromJson(x))),
    keyword: json["keyword"],
  );

  Map<String, dynamic> toJson() => {
    "is_registered": isRegistered,
    "is_analytics": isAnalytics,
    "moniterIntervel": moniterIntervel,
    "caseInsensitive": caseInsensitive,
    "_id": id,
    "id": datumId,
    "name": name,
    "url": url,
    "email": List<dynamic>.from(email!.map((x) => x.toJson())),
    "keyword": keyword,
  };
}

class Email {
  bool ? isEnabled;
  String ? id;
  String ? mailId;

  Email({
     this.isEnabled,
     this.id,
     this.mailId,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
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

class UserData {
  String ? id;
  String ? googleId;
  String ? userName;
  Tokens ? tokens;
  String ? email;
  String ? profilePicture;
  int ? phNo;
  bool ? isRegistered;

  UserData({
     this.id,
     this.googleId,
     this.userName,
     this.tokens,
     this.email,
     this.profilePicture,
     this.phNo,
     this.isRegistered,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    googleId: json["googleId"],
    userName: json["userName"],
    tokens: Tokens.fromJson(json["tokens"]),
    email: json["email"],
    profilePicture: json["profilePicture"],
    phNo: json["phNo"],
    isRegistered: json["is_registered"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "googleId": googleId,
    "userName": userName,
    "tokens": tokens!.toJson(),
    "email": email,
    "profilePicture": profilePicture,
    "phNo": phNo,
    "is_registered": isRegistered,
  };
}

class Tokens {
  String ? accessToken;
  String ? refreshToken;

  Tokens({
     this.accessToken,
     this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}
