// To parse this JSON data, do
//
//     final componentRouteResponse = componentRouteResponseFromJson(jsonString);

import 'dart:convert';

ComponentRouteResponse componentRouteResponseFromJson(String str) => ComponentRouteResponse.fromJson(json.decode(str));

String componentRouteResponseToJson(ComponentRouteResponse data) => json.encode(data.toJson());

class ComponentRouteResponse {
  ComponentRouteResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory ComponentRouteResponse.fromJson(Map<String, dynamic> json) => ComponentRouteResponse(
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
    this.model,
    this.component,
    this.routes,
  });

  Model model;
  Component component;
  List<Route> routes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    model: Model.fromJson(json["model"]),
    component: Component.fromJson(json["component"]),
    routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "model": model.toJson(),
    "component": component.toJson(),
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
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

class Model {
  Model({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
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
    this.sequence,
    this.processName,
    this.processImage,
    this.totalProblem,
  });

  int id;
  int sequence;
  String processName;
  String processImage;
  int totalProblem;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    sequence: json["sequence"],
    processName: json["processName"],
    processImage: json["processImage"],
    totalProblem: json["totalProblem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sequence": sequence,
    "processName": processName,
    "processImage": processImage,
    "totalProblem": totalProblem,
  };
}
