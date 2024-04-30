// To parse this JSON data, do
//
//     final postCommentModel = postCommentModelFromJson(jsonString);

import 'dart:convert';

PostCommentModel postCommentModelFromJson(String str) => PostCommentModel.fromJson(json.decode(str));

String postCommentModelToJson(PostCommentModel data) => json.encode(data.toJson());

class PostCommentModel {
  String ? message;
  int ? code;
  Data ? data;

  PostCommentModel({
     this.message,
     this.code,
     this.data,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => PostCommentModel(
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
  String ?  category;
  bool ? status;
  String ? id;
  String ? viewid;
  String ? name;
  int ? phone;
  String ? email;
  String ? message;
  DateTime ? date;
  int ? v;
  List<Comment> ? comments;

  Data({
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
     this.comments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
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
