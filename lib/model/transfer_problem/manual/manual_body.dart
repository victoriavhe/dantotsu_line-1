// To parse this JSON data, do
//
//     final manualBody = manualBodyFromJson(jsonString);

import 'dart:convert';

ManualBody manualBodyFromJson(String str) => ManualBody.fromJson(json.decode(str));

String manualBodyToJson(ManualBody data) => json.encode(data.toJson());

class ManualBody {
  ManualBody({
    this.transferComponentId,
    this.problemId,
  });

  String transferComponentId;
  String problemId;

  factory ManualBody.fromJson(Map<String, dynamic> json) => ManualBody(
    transferComponentId: json["transferComponentId"],
    problemId: json["problemId"],
  );

  Map<String, dynamic> toJson() => {
    "transferComponentId": transferComponentId,
    "problemId": problemId,
  };
}
