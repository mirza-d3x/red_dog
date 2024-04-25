// To parse this JSON data, do
//
//     final acquisitionTopChannelsModel = acquisitionTopChannelsModelFromJson(jsonString);

import 'dart:convert';

AcquisitionTopChannelsModel acquisitionTopChannelsModelFromJson(String str) => AcquisitionTopChannelsModel.fromJson(json.decode(str));

String acquisitionTopChannelsModelToJson(AcquisitionTopChannelsModel data) => json.encode(data.toJson());

class AcquisitionTopChannelsModel {
  String ? message;
  int ? code;
  List<TopChannelData> ? data;

  AcquisitionTopChannelsModel({
     this.message,
     this.code,
     this.data,
  });

  factory AcquisitionTopChannelsModel.fromJson(Map<String, dynamic> json) => AcquisitionTopChannelsModel(
    message: json["message"],
    code: json["code"],
    data: List<TopChannelData>.from(json["data"].map((x) => TopChannelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TopChannelData {
  String ? key;
  dynamic value;

  TopChannelData({
     this.key,
     this.value,
  });

  factory TopChannelData.fromJson(Map<String, dynamic> json) => TopChannelData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
