// To parse this JSON data, do
//
//     final inspectorCpBody = inspectorCpBodyFromJson(jsonString);

import 'dart:convert';

InspectorCpBody inspectorCpBodyFromJson(String str) =>
    InspectorCpBody.fromJson(json.decode(str));

String inspectorCpBodyToJson(InspectorCpBody data) =>
    json.encode(data.toJson());

class InspectorCpBody {
  InspectorCpBody({
    this.componentRfidId,
    this.checkPointId,
    this.defectLength,
    this.defectDepthFrom,
    this.defectDepthTo,
    this.result,
    this.remark,
  });

  String componentRfidId;
  String checkPointId;
  String defectLength;
  String defectDepthFrom;
  String defectDepthTo;
  String result;
  String remark;

  InspectorCpBody copyWith({
    String componentRfidId,
    String checkPointId,
    String defectLength,
    String defectDepthFrom,
    String defectDepthTo,
    String result,
    String remark,
  }) =>
      InspectorCpBody(
        componentRfidId: componentRfidId ?? this.componentRfidId,
        checkPointId: checkPointId ?? this.checkPointId,
        defectLength: defectLength ?? this.defectLength,
        defectDepthFrom: defectDepthFrom ?? this.defectDepthFrom,
        defectDepthTo: defectDepthTo ?? this.defectDepthTo,
        result: result ?? this.result,
        remark: remark ?? this.remark,
      );

  factory InspectorCpBody.fromJson(Map<String, dynamic> json) =>
      InspectorCpBody(
        componentRfidId: json["componentRfidId"],
        checkPointId: json["checkPointId"],
        defectLength: json["defectLength"],
        defectDepthFrom: json["defectDepthFrom"],
        defectDepthTo: json["defectDepthTo"],
        result: json["result"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "componentRfidId": componentRfidId,
        "checkPointId": checkPointId,
        "defectLength": defectLength,
        "defectDepthFrom": defectDepthFrom,
        "defectDepthTo": defectDepthTo,
        "result": result,
        "remark": remark,
      };
}
