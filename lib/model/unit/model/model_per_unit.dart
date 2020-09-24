// To parse this JSON data, do
//
//     final unitModelResponse = unitModelResponseFromJson(jsonString);

import 'dart:convert';

UnitModelResponse unitModelResponseFromJson(String str) => UnitModelResponse.fromJson(json.decode(str));

String unitModelResponseToJson(UnitModelResponse data) => json.encode(data.toJson());

class UnitModelResponse {
  UnitModelResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory UnitModelResponse.fromJson(Map<String, dynamic> json) => UnitModelResponse(
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
    this.unit,
    this.models,
  });

  Unit unit;
  List<Model> models;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    unit: Unit.fromJson(json["unit"]),
    models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unit": unit.toJson(),
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };
}

class Model {
  Model({
    this.id,
    this.name,
    this.totalProblem,
  });

  int id;
  String name;
  int totalProblem;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    name: json["name"],
    totalProblem: json["totalProblem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "totalProblem": totalProblem,
  };
}

class Unit {
  Unit({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
