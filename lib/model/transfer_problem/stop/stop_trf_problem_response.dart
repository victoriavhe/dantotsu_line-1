// To parse this JSON data, do
//
//     final stopTpResponse = stopTpResponseFromJson(jsonString);

import 'dart:convert';

StopTpResponse stopTpResponseFromJson(String str) => StopTpResponse.fromJson(json.decode(str));

String stopTpResponseToJson(StopTpResponse data) => json.encode(data.toJson());

class StopTpResponse {
  StopTpResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  StopTpResponse copyWith({
    String result,
    String message,
    Data data,
  }) =>
      StopTpResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory StopTpResponse.fromJson(Map<String, dynamic> json) => StopTpResponse(
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
    this.transferProblem,
  });

  TransferProblem transferProblem;

  Data copyWith({
    TransferProblem transferProblem,
  }) =>
      Data(
        transferProblem: transferProblem ?? this.transferProblem,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transferProblem: TransferProblem.fromJson(json["transferProblem"]),
  );

  Map<String, dynamic> toJson() => {
    "transferProblem": transferProblem.toJson(),
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
    this.end,
    this.totalTime,
  });

  int id;
  String componentName;
  String serialNumber;
  String processName;
  String problemName;
  String start;
  String end;
  String totalTime;

  TransferProblem copyWith({
    int id,
    String componentName,
    String serialNumber,
    String processName,
    String problemName,
    String start,
    String end,
    String totalTime,
  }) =>
      TransferProblem(
        id: id ?? this.id,
        componentName: componentName ?? this.componentName,
        serialNumber: serialNumber ?? this.serialNumber,
        processName: processName ?? this.processName,
        problemName: problemName ?? this.problemName,
        start: start ?? this.start,
        end: end ?? this.end,
        totalTime: totalTime ?? this.totalTime,
      );

  factory TransferProblem.fromJson(Map<String, dynamic> json) => TransferProblem(
    id: json["id"],
    componentName: json["componentName"],
    serialNumber: json["serialNumber"],
    processName: json["processName"],
    problemName: json["problemName"],
    start: json["start"],
    end: json["end"],
    totalTime: json["totalTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "componentName": componentName,
    "serialNumber": serialNumber,
    "processName": processName,
    "problemName": problemName,
    "start": start,
    "end": end,
    "totalTime": totalTime,
  };
}
