// To parse this JSON data, do
//
//     final reasonTrfProblemBody = reasonTrfProblemBodyFromJson(jsonString);

import 'dart:convert';

ReasonTrfProblemBody reasonTrfProblemBodyFromJson(String str) => ReasonTrfProblemBody.fromJson(json.decode(str));

String reasonTrfProblemBodyToJson(ReasonTrfProblemBody data) => json.encode(data.toJson());

class ReasonTrfProblemBody {
  ReasonTrfProblemBody({
    this.transferProblemId,
    this.problemId,
  });

  String transferProblemId;
  String problemId;

  factory ReasonTrfProblemBody.fromJson(Map<String, dynamic> json) => ReasonTrfProblemBody(
    transferProblemId: json["transferProblemId"],
    problemId: json["problemId"],
  );

  Map<String, dynamic> toJson() => {
    "transferProblemId": transferProblemId,
    "problemId": problemId,
  };
}
