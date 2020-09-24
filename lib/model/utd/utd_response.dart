// To parse this JSON data, do
//
//     final utdResponse = utdResponseFromJson(jsonString);

import 'dart:convert';

UtdResponse utdResponseFromJson(String str) => UtdResponse.fromJson(json.decode(str));

String utdResponseToJson(UtdResponse data) => json.encode(data.toJson());

class UtdResponse {
  UtdResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  UtdResponse copyWith({
    String result,
    String message,
    Data data,
  }) =>
      UtdResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UtdResponse.fromJson(Map<String, dynamic> json) => UtdResponse(
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
    this.year,
    this.month,
    this.componentRfids,
  });

  String year;
  String month;
  List<ComponentRfid> componentRfids;

  Data copyWith({
    String year,
    String month,
    List<ComponentRfid> componentRfids,
  }) =>
      Data(
        year: year ?? this.year,
        month: month ?? this.month,
        componentRfids: componentRfids ?? this.componentRfids,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    year: json["year"],
    month: json["month"],
    componentRfids: List<ComponentRfid>.from(json["componentRfids"].map((x) => ComponentRfid.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "componentRfids": List<dynamic>.from(componentRfids.map((x) => x.toJson())),
  };
}

class ComponentRfid {
  ComponentRfid({
    this.id,
    this.serialNumber,
    this.model,
    this.component,
    this.status,
  });

  int id;
  String serialNumber;
  Model model;
  Component component;
  String status;

  ComponentRfid copyWith({
    int id,
    String serialNumber,
    Model model,
    Component component,
    String status,
  }) =>
      ComponentRfid(
        id: id ?? this.id,
        serialNumber: serialNumber ?? this.serialNumber,
        model: model ?? this.model,
        component: component ?? this.component,
        status: status ?? this.status,
      );

  factory ComponentRfid.fromJson(Map<String, dynamic> json) => ComponentRfid(
    id: json["id"],
    serialNumber: json["serialNumber"],
    model: Model.fromJson(json["model"]),
    component: Component.fromJson(json["component"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialNumber": serialNumber,
    "model": model.toJson(),
    "component": component.toJson(),
    "status": status,
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

class Model {
  Model({
    this.id,
    this.name,
  });

  int id;
  String name;

  Model copyWith({
    int id,
    String name,
  }) =>
      Model(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
