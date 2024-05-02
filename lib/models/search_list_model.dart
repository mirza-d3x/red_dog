// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  SearchResultModel({
     this.message,
     this.code,
     this.data,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
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
  String ? category;
  bool ? status;
  String ? id;
  String ? viewid;
  String ? name;
  int ? phone;
  String ? email;
  String ? message;
  DateTime ? date;
  int ? v;
  String ? file;
  List<Comment> ? comments;

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
     this.comments,
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
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comment {
  String ?  id;
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