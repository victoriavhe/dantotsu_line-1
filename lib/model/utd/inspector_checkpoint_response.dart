// To parse this JSON data, do
//
//     final inspectorCpResponses = inspectorCpResponsesFromJson(jsonString);

import 'dart:convert';

InspectorCpResponses inspectorCpResponsesFromJson(String str) => InspectorCpResponses.fromJson(json.decode(str));

String inspectorCpResponsesToJson(InspectorCpResponses data) => json.encode(data.toJson());

class InspectorCpResponses {
  InspectorCpResponses({
    this.result,
    this.message,
  });

  String result;
  String message;

  InspectorCpResponses copyWith({
    String result,
    String message,
  }) =>
      InspectorCpResponses(
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory InspectorCpResponses.fromJson(Map<String, dynamic> json) => InspectorCpResponses(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
