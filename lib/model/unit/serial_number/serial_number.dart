// To parse this JSON data, do
//
//     final serialNumberResponse = serialNumberResponseFromJson(jsonString);

import 'dart:convert';

SerialNumberResponse serialNumberResponseFromJson(String str) => SerialNumberResponse.fromJson(json.decode(str));

String serialNumberResponseToJson(SerialNumberResponse data) => json.encode(data.toJson());

class SerialNumberResponse {
  SerialNumberResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory SerialNumberResponse.fromJson(Map<String, dynamic> json) => SerialNumberResponse(
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
    this.route,
    this.serialNumbers,
  });

  Component component;
  Route route;
  List<SerialNumber> serialNumbers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    component: Component.fromJson(json["component"]),
    route: Route.fromJson(json["route"]),
    serialNumbers: List<SerialNumber>.from(json["serialNumbers"].map((x) => SerialNumber.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "component": component.toJson(),
    "route": route.toJson(),
    "serialNumbers": List<dynamic>.from(serialNumbers.map((x) => x.toJson())),
  };
}

class Component {
  Component({
    this.id,
    this.description,
  });

  int id;
  String description;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}

class Route {
  Route({
    this.id,
  });

  String id;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class SerialNumber {
  SerialNumber({
    this.transferComponentId,
    this.serialNumber,
    this.totalProblem,
    this.problems,
  });

  String transferComponentId;
  String serialNumber;
  int totalProblem;
  List<Problem> problems;

  factory SerialNumber.fromJson(Map<String, dynamic> json) => SerialNumber(
    transferComponentId: json["transferComponentId"],
    serialNumber: json["serialNumber"],
    totalProblem: json["totalProblem"],
    problems: List<Problem>.from(json["transferProblems"].map((x) => Problem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transferComponentId": transferComponentId,
    "serialNumber": serialNumber,
    "totalProblem": totalProblem,
    "transferProblems": List<dynamic>.from(problems.map((x) => x.toJson())),
  };
}

class Problem {
  Problem({
    this.id,
  });

  int id;

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
