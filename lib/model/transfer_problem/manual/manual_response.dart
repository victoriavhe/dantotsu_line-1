// To parse this JSON data, do
//
//     final manualResponse = manualResponseFromJson(jsonString);

import 'dart:convert';

ManualResponse manualResponseFromJson(String str) => ManualResponse.fromJson(json.decode(str));

String manualResponseToJson(ManualResponse data) => json.encode(data.toJson());

class ManualResponse {
  ManualResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory ManualResponse.fromJson(Map<String, dynamic> json) => ManualResponse(
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

  int transferProblemId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transferProblemId: json["transferProblemId"],
  );

  Map<String, dynamic> toJson() => {
    "transferProblemId": transferProblemId,
  };
}
