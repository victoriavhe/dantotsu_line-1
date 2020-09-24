// To parse this JSON data, do
//
//     final utdSerialNumber = utdSerialNumberFromJson(jsonString);

import 'dart:convert';

UtdSerialNumber utdSerialNumberFromJson(String str) => UtdSerialNumber.fromJson(json.decode(str));

String utdSerialNumberToJson(UtdSerialNumber data) => json.encode(data.toJson());

class UtdSerialNumber {
  UtdSerialNumber({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  UtdSerialNumber copyWith({
    String result,
    String message,
    Data data,
  }) =>
      UtdSerialNumber(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UtdSerialNumber.fromJson(Map<String, dynamic> json) => UtdSerialNumber(
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
    this.component,
    this.serialNumbers,
  });

  Component component;
  List<SerialNumber> serialNumbers;

  Data copyWith({
    Component component,
    List<SerialNumber> serialNumbers,
  }) =>
      Data(
        component: component ?? this.component,
        serialNumbers: serialNumbers ?? this.serialNumbers,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    component: Component.fromJson(json["component"]),
    serialNumbers: List<SerialNumber>.from(json["serialNumbers"].map((x) => SerialNumber.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "component": component.toJson(),
    "serialNumbers": List<dynamic>.from(serialNumbers.map((x) => x.toJson())),
  };
}

class Component {
  Component({
    this.id,
    this.partNo,
    this.description,
  });

  int id;
  String partNo;
  String description;

  Component copyWith({
    int id,
    String partNo,
    String description,
  }) =>
      Component(
        id: id ?? this.id,
        partNo: partNo ?? this.partNo,
        description: description ?? this.description,
      );

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json["id"],
    partNo: json["partNo"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "partNo": partNo,
    "description": description,
  };
}

class SerialNumber {
  SerialNumber({
    this.componentRfidId,
    this.serialNumber,
  });

  int componentRfidId;
  String serialNumber;

  SerialNumber copyWith({
    int componentRfidId,
    String serialNumber,
  }) =>
      SerialNumber(
        componentRfidId: componentRfidId ?? this.componentRfidId,
        serialNumber: serialNumber ?? this.serialNumber,
      );

  factory SerialNumber.fromJson(Map<String, dynamic> json) => SerialNumber(
    componentRfidId: json["componentRfidId"],
    serialNumber: json["serialNumber"],
  );

  Map<String, dynamic> toJson() => {
    "componentRfidId": componentRfidId,
    "serialNumber": serialNumber,
  };
}
