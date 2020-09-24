// To parse this JSON data, do
//
//     final stopTrfProblemBody = stopTrfProblemBodyFromJson(jsonString);

import 'dart:convert';

StopTrfProblemBody stopTrfProblemBodyFromJson(String str) => StopTrfProblemBody.fromJson(json.decode(str));

String stopTrfProblemBodyToJson(StopTrfProblemBody data) => json.encode(data.toJson());

class StopTrfProblemBody {
  StopTrfProblemBody({
    this.transferProblemId,
  });

  String transferProblemId;

  factory StopTrfProblemBody.fromJson(Map<String, dynamic> json) => StopTrfProblemBody(
    transferProblemId: json["transferProblemId"],
  );

  Map<String, dynamic> toJson() => {
    "transferProblemId": transferProblemId,
  };
}
