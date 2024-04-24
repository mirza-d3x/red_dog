// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) => GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) => json.encode(data.toJson());

class GetNotificationModel {
  String ? code;
  String ? status;
  String ? message;
  List<Notification> ? notifications;

  GetNotificationModel({
     this.code,
     this.status,
     this.message,
     this.notifications,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  String ? id;
  String ? email;
  String ? url;
  String ? type;
  String ? description;
  String ? title;
  DateTime ? createdDate;
  DateTime ? updatedDate;
  int ? v;

  Notification({
     this.id,
     this.email,
     this.url,
     this.type,
     this.description,
     this.title,
     this.createdDate,
     this.updatedDate,
     this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["_id"],
    email: json["email"],
    url: json["url"],
    type: json["type"],
    description: json["description"],
    title: json["title"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "url": url,
    "type": type,
    "description": description,
    "title": title,
    "created_date": createdDate!.toIso8601String(),
    "updated_date": updatedDate!.toIso8601String(),
    "__v": v,
  };
}
