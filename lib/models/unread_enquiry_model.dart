// To parse this JSON data, do
//
//     final unReadEnquiryModel = unReadEnquiryModelFromJson(jsonString);

import 'dart:convert';

UnReadEnquiryModel unReadEnquiryModelFromJson(String str) => UnReadEnquiryModel.fromJson(json.decode(str));

String unReadEnquiryModelToJson(UnReadEnquiryModel data) => json.encode(data.toJson());

class UnReadEnquiryModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  UnReadEnquiryModel({
     this.message,
     this.code,
     this.data,
  });

  factory UnReadEnquiryModel.fromJson(Map<String, dynamic> json) => UnReadEnquiryModel(
    message: json["message"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  dynamic category;
  bool ? status;
  String ? id;
  List<Comment> ? comments;
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
     this.comments,
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
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
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

class Comment {
  String ? id;
  String ? message;
  DateTime ? createdDate;
  DateTime ? updatedDate;

  Comment({
     this.id,
     this.message,
     this.createdDate,
     this.updatedDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    message: json["message"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "created_date": createdDate!.toIso8601String(),
    "updated_date": updatedDate!.toIso8601String(),
  };
}

