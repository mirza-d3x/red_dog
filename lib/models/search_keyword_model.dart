// To parse this JSON data, do
//
//     final searchKeywordModel = searchKeywordModelFromJson(jsonString);

import 'dart:convert';

SearchKeywordModel searchKeywordModelFromJson(String str) => SearchKeywordModel.fromJson(json.decode(str));

String searchKeywordModelToJson(SearchKeywordModel data) => json.encode(data.toJson());

class SearchKeywordModel {
  String ? message;
  int ? code;
  List<Datum> ? data;

  SearchKeywordModel({
     this.message,
     this.code,
     this.data,
  });

  factory SearchKeywordModel.fromJson(Map<String, dynamic> json) => SearchKeywordModel(
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
  String ? keyword;
  int ? searches;
  String ? percentage;

  Datum({
     this.keyword,
     this.searches,
     this.percentage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    keyword: json["keyword"],
    searches: json["searches"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "searches": searches,
    "percentage": percentage,
  };
}
