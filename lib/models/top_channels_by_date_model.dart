// To parse this JSON data, do
//
//     final channelsByDateModel = channelsByDateModelFromJson(jsonString);

import 'dart:convert';

ChannelsByDateModel channelsByDateModelFromJson(String str) => ChannelsByDateModel.fromJson(json.decode(str));

String channelsByDateModelToJson(ChannelsByDateModel data) => json.encode(data.toJson());

class ChannelsByDateModel {
  String ? message;
  int ? code;
  AxisData ? data;

  ChannelsByDateModel({
     this.message,
     this.code,
     this.data,
  });

  factory ChannelsByDateModel.fromJson(Map<String, dynamic> json) => ChannelsByDateModel(
    message: json["message"],
    code: json["code"],
    data: AxisData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data!.toJson(),
  };
}

class AxisData {
  List<dynamic> ? xaxis;
  List<Series> ? series;

  AxisData({
     this.xaxis,
     this.series,
  });

  factory AxisData.fromJson(Map<String, dynamic> json) => AxisData(
    xaxis: List<String>.from(json["xaxis"].map((x) => x)),
    series: List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "xaxis": List<dynamic>.from(xaxis!.map((x) => x)),
    "series": List<dynamic>.from(series!.map((x) => x.toJson())),
  };
}

class Series {
  String ? name;
  List<String> ? data;

  Series({
     this.name,
     this.data,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    name: json["name"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
