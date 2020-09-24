// To parse this JSON data, do
//
//     final unreasonTrfProblem = unreasonTrfProblemFromJson(jsonString);

import 'dart:convert';

UnreasonTrfProblem unreasonTrfProblemFromJson(String str) => UnreasonTrfProblem.fromJson(json.decode(str));

String unreasonTrfProblemToJson(UnreasonTrfProblem data) => json.encode(data.toJson());

class UnreasonTrfProblem {
  UnreasonTrfProblem({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory UnreasonTrfProblem.fromJson(Map<String, dynamic> json) => UnreasonTrfProblem(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.totalProblem,
  });

  int totalProblem;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalProblem: json["totalProblem"],
  );

  Map<String, dynamic> toJson() => {
    "totalProblem": totalProblem,
  };
}
