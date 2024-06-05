// To parse this JSON data, do
//
//     final serverTileModel = serverTileModelFromJson(jsonString);

import 'dart:convert';

ServerTileModel serverTileModelFromJson(String str) => ServerTileModel.fromJson(json.decode(str));

String serverTileModelToJson(ServerTileModel data) => json.encode(data.toJson());

class ServerTileModel {
  String ? message;
  int ? code;
  Data ? data;

  ServerTileModel({
     this.message,
     this.code,
     this.data,
  });

  factory ServerTileModel.fromJson(Map<String, dynamic> json) => ServerTileModel(
    message: json["message"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data!.toJson(),
  };
}

class Data {
  int ? uptime;
  String ? domainExpiry;
  String ? domainStatus;

  Data({
     this.uptime,
     this.domainExpiry,
     this.domainStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uptime: json["uptime"],
    domainExpiry: json["domainExpiry"],
    domainStatus: json["domainStatus"],
  );

  Map<String, dynamic> toJson() => {
    "uptime": uptime,
    "domainExpiry": domainExpiry,
    "domainStatus": domainStatus,
  };
}
