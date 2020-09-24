// To parse this JSON data, do
//
//     final modelComponentResponse = modelComponentResponseFromJson(jsonString);

import 'dart:convert';

ModelComponentResponse modelComponentResponseFromJson(String str) => ModelComponentResponse.fromJson(json.decode(str));

String modelComponentResponseToJson(ModelComponentResponse data) => json.encode(data.toJson());

class ModelComponentResponse {
  ModelComponentResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory ModelComponentResponse.fromJson(Map<String, dynamic> json) => ModelComponentResponse(
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
    this.components,
  });

  Model model;
  List<Component> components;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    model: Model.fromJson(json["model"]),
    components: List<Component>.from(json["components"].map((x) => Component.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "model": model.toJson(),
    "components": List<dynamic>.from(components.map((x) => x.toJson())),
  };
}

class Component {
  Component({
    this.id,
    this.partNo,
    this.description,
    this.totalProblem,
  });

  int id;
  String partNo;
  String description;
  int totalProblem;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json["id"],
    partNo: json["partNo"],
    description: json["description"],
    totalProblem: json["totalProblem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "partNo": partNo,
    "description": description,
    "totalProblem": totalProblem,
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
