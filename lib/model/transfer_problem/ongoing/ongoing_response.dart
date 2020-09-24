// To parse this JSON data, do
//
//     final ongoingResponse = ongoingResponseFromJson(jsonString);

import 'dart:convert';

OngoingResponse ongoingResponseFromJson(String str) => OngoingResponse.fromJson(json.decode(str));

String ongoingResponseToJson(OngoingResponse data) => json.encode(data.toJson());

class OngoingResponse {
  OngoingResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory OngoingResponse.fromJson(Map<String, dynamic> json) => OngoingResponse(
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
    this.transferProblems,
  });

  List<TransferProblem> transferProblems;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transferProblems: List<TransferProblem>.from(json["transferProblems"].map((x) => TransferProblem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transferProblems": List<dynamic>.from(transferProblems.map((x) => x.toJson())),
  };
}

class TransferProblem {
  TransferProblem({
    this.id,
    this.componentName,
    this.serialNumber,
    this.processName,
    this.problemName,
    this.start,
  });

  int id;
  String componentName;
  String serialNumber;
  String processName;
  String problemName;
  String start;

  factory TransferProblem.fromJson(Map<String, dynamic> json) => TransferProblem(
    id: json["id"],
    componentName: json["componentName"],
    serialNumber: json["serialNumber"],
    processName: json["processName"],
    problemName: json["problemName"],
    start: json["start"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "componentName": componentName,
    "serialNumber": serialNumber,
    "processName": processName,
    "problemName": problemName,
    "start": start,
  };
}
