// To parse this JSON data, do
//
//     final channelsByDateModel = channelsByDateModelFromJson(jsonString);

import 'dart:convert';

ChannelsByDateModel channelsByDateModelFromJson(String str) => ChannelsByDateModel.fromJson(json.decode(str));

String channelsByDateModelToJson(ChannelsByDateModel data) => json.encode(data.toJson());

class ChannelsByDateModel {
  String ? message;
  int ? code;
  List<ChannelsByDateModelDatum> ? data;

  ChannelsByDateModel({
     this.message,
     this.code,
     this.data,
  });

  factory ChannelsByDateModel.fromJson(Map<String, dynamic> json) => ChannelsByDateModel(
    message: json["message"],
    code: json["code"],
    data: List<ChannelsByDateModelDatum>.from(json["data"].map((x) => ChannelsByDateModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChannelsByDateModelDatum {
  String ? name;
  List<ChannelsByDateValues> ? data;

  ChannelsByDateModelDatum({
     this.name,
     this.data,
  });

  factory ChannelsByDateModelDatum.fromJson(Map<String, dynamic> json) => ChannelsByDateModelDatum(
    name: json["name"],
    data: List<ChannelsByDateValues>.from(json["data"].map((x) => ChannelsByDateValues.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChannelsByDateValues {
  String ? key;
  String ? value;

  ChannelsByDateValues({
     required this.key,
     required this.value,
  });

  factory ChannelsByDateValues.fromJson(Map<String, dynamic> json) => ChannelsByDateValues(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
