// To parse this JSON data, do
//
//     final tpFromAlarmResponse = tpFromAlarmResponseFromJson(jsonString);

import 'dart:convert';

TpFromAlarmResponse tpFromAlarmResponseFromJson(String str) => TpFromAlarmResponse.fromJson(json.decode(str));

String tpFromAlarmResponseToJson(TpFromAlarmResponse data) => json.encode(data.toJson());

class TpFromAlarmResponse {
  TpFromAlarmResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory TpFromAlarmResponse.fromJson(Map<String, dynamic> json) => TpFromAlarmResponse(
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
    this.transferProblemId,
  });

  String transferProblemId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transferProblemId: json["transferProblemId"],
  );

  Map<String, dynamic> toJson() => {
    "transferProblemId": transferProblemId,
  };
}
