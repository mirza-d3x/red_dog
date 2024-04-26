// To parse this JSON data, do
//
//     final leadDetailsWithFilterTileModel = leadDetailsWithFilterTileModelFromJson(jsonString);

import 'dart:convert';

LeadDetailsWithFilterTileModel leadDetailsWithFilterTileModelFromJson(String str) => LeadDetailsWithFilterTileModel.fromJson(json.decode(str));

String leadDetailsWithFilterTileModelToJson(LeadDetailsWithFilterTileModel data) => json.encode(data.toJson());

class LeadDetailsWithFilterTileModel {
  String ? message;
  int ? code;
  List<Datum> ? data;
  int ? total;

  LeadDetailsWithFilterTileModel({
     this.message,
     this.code,
     this.data,
     this.total,
  });

  factory LeadDetailsWithFilterTileModel.fromJson(Map<String, dynamic> json) => LeadDetailsWithFilterTileModel(
    message: json["message"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total,
  };
}

class Datum {
  dynamic category;
  String ? status;
  String ? id;
  String ? viewid;
  String ? name;
  int ? phone;
  String ? email;
  String ? message;
  DateTime ? date;
  int ? v;
  String ? file;

  Datum({
     this.category,
     this.status,
     this.id,
     this.viewid,
     this.name,
    this.phone,
     this.email,
     this.message,
     this.date,
     this.v,
    this.file,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    category: json["category"],
    status: json["status"],
    id: json["_id"],
    viewid: json["viewid"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    message: json["message"],
    date: DateTime.parse(json["date"]),
    v: json["__v"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "status": status,
    "_id": id,
    "viewid": viewid,
    "name": name,
    "phone": phone,
    "email": email,
    "message": message,
    "date": date!.toIso8601String(),
    "__v": v,
    "file": file,
  };
}

