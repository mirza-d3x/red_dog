// To parse this JSON data, do
//
//     final deviceCategoryModel = deviceCategoryModelFromJson(jsonString);

import 'dart:convert';

DeviceCategoryModel deviceCategoryModelFromJson(String str) => DeviceCategoryModel.fromJson(json.decode(str));

String deviceCategoryModelToJson(DeviceCategoryModel data) => json.encode(data.toJson());

class DeviceCategoryModel {
  String ? message;
  int ? code;
  List<DeviceCategoryData> ? data;

  DeviceCategoryModel({
     this.message,
     this.code,
     this.data,
  });

  factory DeviceCategoryModel.fromJson(Map<String, dynamic> json) => DeviceCategoryModel(
    message: json["message"],
    code: json["code"],
    data: List<DeviceCategoryData>.from(json["data"].map((x) => DeviceCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DeviceCategoryData {
  String ? key;
  int ? value;

  DeviceCategoryData({
     this.key,
     this.value,
  });

  factory DeviceCategoryData.fromJson(Map<String, dynamic> json) => DeviceCategoryData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
