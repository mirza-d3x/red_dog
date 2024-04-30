// To parse this JSON data, do
//
//     final updateCommentModel = updateCommentModelFromJson(jsonString);

import 'dart:convert';

UpdateCommentModel updateCommentModelFromJson(String str) => UpdateCommentModel.fromJson(json.decode(str));

String updateCommentModelToJson(UpdateCommentModel data) => json.encode(data.toJson());

class UpdateCommentModel {
  String ? message;
  int ? code;
  Data ? data;

  UpdateCommentModel({
     this.message,
     this.code,
     this.data,
  });

  factory UpdateCommentModel.fromJson(Map<String, dynamic> json) => UpdateCommentModel(
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
  int ? n;
  int ? nModified;
  int ? ok;

  Data({
     this.n,
     this.nModified,
     this.ok,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    n: json["n"],
    nModified: json["nModified"],
    ok: json["ok"],
  );

  Map<String, dynamic> toJson() => {
    "n": n,
    "nModified": nModified,
    "ok": ok,
  };
}
