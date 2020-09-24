// To parse this JSON data, do
//
//     final unitResponse = unitResponseFromJson(jsonString);

import 'dart:convert';

UnitResponse unitResponseFromJson(String str) => UnitResponse.fromJson(json.decode(str));

String unitResponseToJson(UnitResponse data) => json.encode(data.toJson());

class UnitResponse {
  UnitResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory UnitResponse.fromJson(Map<String, dynamic> json) => UnitResponse(
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
    this.units,
  });

  List<Unit> units;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
  };
}

class Unit {
  Unit({
    this.id,
    this.name,
    this.image,
    this.totalProblem,
  });

  int id;
  String name;
  String image;
  int totalProblem;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    totalProblem: json["totalProblem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "totalProblem": totalProblem,
  };
}
