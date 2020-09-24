// To parse this JSON data, do
//
//     final problemResponse = problemResponseFromJson(jsonString);

import 'dart:convert';

ProblemResponse problemResponseFromJson(String str) => ProblemResponse.fromJson(json.decode(str));

String problemResponseToJson(ProblemResponse data) => json.encode(data.toJson());

class ProblemResponse {
  ProblemResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory ProblemResponse.fromJson(Map<String, dynamic> json) => ProblemResponse(
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
    this.transferComponentId,
    this.transferProblemId,
    this.component,
    this.serialNumber,
    this.route,
    this.problems,
  });

  String transferComponentId;
  String transferProblemId;
  Component component;
  String serialNumber;
  Route route;
  List<Problem> problems;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transferComponentId: json["transferComponentId"],
    transferProblemId: json["transferProblemId"],
    component: Component.fromJson(json["component"]),
    serialNumber: json["serialNumber"],
    route: Route.fromJson(json["route"]),
    problems: List<Problem>.from(json["problems"].map((x) => Problem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transferComponentId": transferComponentId,
    "transferProblemId": transferProblemId,
    "component": component.toJson(),
    "serialNumber": serialNumber,
    "route": route.toJson(),
    "problems": List<dynamic>.from(problems.map((x) => x.toJson())),
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

class Problem {
  Problem({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Route {
  Route({
    this.id,
    this.processName,
  });

  int id;
  String processName;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    processName: json["processName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "processName": processName,
  };
}
