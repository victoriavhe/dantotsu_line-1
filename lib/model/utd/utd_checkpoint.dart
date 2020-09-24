// To parse this JSON data, do
//
//     final utdCheckpoint = utdCheckpointFromJson(jsonString);

import 'dart:convert';

UtdCheckpoint utdCheckpointFromJson(String str) =>
    UtdCheckpoint.fromJson(json.decode(str));

String utdCheckpointToJson(UtdCheckpoint data) => json.encode(data.toJson());

class UtdCheckpoint {
  UtdCheckpoint({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  UtdCheckpoint copyWith({
    String result,
    String message,
    Data data,
  }) =>
      UtdCheckpoint(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UtdCheckpoint.fromJson(Map<String, dynamic> json) => UtdCheckpoint(
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
    this.componentRfidId,
    this.model,
    this.component,
    this.images,
    this.defects,
  });

  String componentRfidId;
  Model model;
  Component component;
  List<ImageCP> images;
  List<Model> defects;

  Data copyWith({
    String componentRfidId,
    Model model,
    Component component,
    List<ImageCP> images,
    List<Model> defects,
  }) =>
      Data(
        componentRfidId: componentRfidId ?? this.componentRfidId,
        model: model ?? this.model,
        component: component ?? this.component,
        images: images ?? this.images,
        defects: defects ?? this.defects,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        componentRfidId: json["componentRfidId"],
        model: Model.fromJson(json["model"]),
        component: Component.fromJson(json["component"]),
        images:
            List<ImageCP>.from(json["images"].map((x) => ImageCP.fromJson(x))),
        defects:
            List<Model>.from(json["defects"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "componentRfidId": componentRfidId,
        "model": model.toJson(),
        "component": component.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "defects": List<dynamic>.from(defects.map((x) => x.toJson())),
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

class ImageCP {
  ImageCP({
    this.id,
    this.name,
    this.image,
    this.width,
    this.height,
    this.checkPointNumbers,
  });

  int id;
  String name;
  String image;
  String width;
  String height;
  List<CheckPointNumber> checkPointNumbers;

  ImageCP copyWith({
    int id,
    String name,
    String image,
    String width,
    String height,
    List<CheckPointNumber> checkPointNumbers,
  }) =>
      ImageCP(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        width: width ?? this.width,
        height: height ?? this.height,
        checkPointNumbers: checkPointNumbers ?? this.checkPointNumbers,
      );

  factory ImageCP.fromJson(Map<String, dynamic> json) => ImageCP(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        width: json["width"],
        height: json["height"],
        checkPointNumbers: List<CheckPointNumber>.from(
            json["checkPointNumbers"].map((x) => CheckPointNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "width": width,
        "height": height,
        "checkPointNumbers":
            List<dynamic>.from(checkPointNumbers.map((x) => x.toJson())),
      };
}

class CheckPointNumber {
  CheckPointNumber({
    this.number,
    this.x,
    this.y,
    this.checkpoints,
  });

  int number;
  String x;
  String y;
  List<Checkpoint> checkpoints;

  CheckPointNumber copyWith({
    int number,
    String x,
    String y,
    List<Checkpoint> checkpoints,
  }) =>
      CheckPointNumber(
        number: number ?? this.number,
        x: x ?? this.x,
        y: y ?? this.y,
        checkpoints: checkpoints ?? this.checkpoints,
      );

  factory CheckPointNumber.fromJson(Map<String, dynamic> json) =>
      CheckPointNumber(
        number: json["number"],
        x: json["x"],
        y: json["y"],
        checkpoints: List<Checkpoint>.from(
            json["checkpoints"].map((x) => Checkpoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "x": x,
        "y": y,
        "checkpoints": List<dynamic>.from(checkpoints.map((x) => x.toJson())),
      };
}

class Checkpoint {
  Checkpoint({
    this.id,
    this.name,
    this.weldingLength,
    this.defectTreshold,
    this.defectDepthMin,
    this.defectDepthMax,
    this.depth,
    this.transferCheckPoints,
  });

  int id;
  String name;
  String weldingLength;
  double defectTreshold;
  double defectDepthMin;
  double defectDepthMax;
  String depth;
  List<TransferCheckPoint> transferCheckPoints;

  Checkpoint copyWith({
    int id,
    String name,
    String weldingLength,
    double defectTreshold,
    double defectDepthMin,
    double defectDepthMax,
    String depth,
    List<TransferCheckPoint> transferCheckPoints,
  }) =>
      Checkpoint(
        id: id ?? this.id,
        name: name ?? this.name,
        weldingLength: weldingLength ?? this.weldingLength,
        defectTreshold: defectTreshold ?? this.defectTreshold,
        defectDepthMin: defectDepthMin ?? this.defectDepthMin,
        defectDepthMax: defectDepthMax ?? this.defectDepthMax,
        depth: depth ?? this.depth,
        transferCheckPoints: transferCheckPoints ?? this.transferCheckPoints,
      );

  factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
        id: json["id"],
        name: json["name"],
        weldingLength: json["weldingLength"],
        defectTreshold: json["defectTreshold"],
        defectDepthMin: json["defectDepthMin"],
        defectDepthMax: json["defectDepthMax"],
        depth: json["depth"],
        transferCheckPoints: List<TransferCheckPoint>.from(
            json["transferCheckPoints"]
                .map((x) => TransferCheckPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weldingLength": weldingLength,
        "defectTreshold": defectTreshold,
        "defectDepthMin": defectDepthMin,
        "defectDepthMax": defectDepthMax,
        "depth": depth,
        "transferCheckPoints":
            List<dynamic>.from(transferCheckPoints.map((x) => x.toJson())),
      };
}

class TransferCheckPoint {
  TransferCheckPoint({
    this.id,
    this.routeId,
    this.sequence,
    this.defectLength,
    this.defectDepthFrom,
    this.defectDepthTo,
    this.result,
    this.remark,
    this.inspectors,
    this.manPowers,
    this.image,
    this.idDefects,
  });

  String id;
  int routeId;
  int sequence;
  String defectLength;
  String defectDepthFrom;
  String defectDepthTo;
  String result;
  String remark;
  List<Inspector> inspectors;
  List<Inspector> manPowers;
  String image;
  List<dynamic> idDefects;

  TransferCheckPoint copyWith({
    String id,
    int routeId,
    int sequence,
    String defectLength,
    String defectDepthFrom,
    String defectDepthTo,
    String result,
    String remark,
    List<Inspector> inspectors,
    List<Inspector> manPowers,
    String image,
    List<dynamic> idDefects,
  }) =>
      TransferCheckPoint(
        id: id ?? this.id,
        routeId: routeId ?? this.routeId,
        sequence: sequence ?? this.sequence,
        defectLength: defectLength ?? this.defectLength,
        defectDepthFrom: defectDepthFrom ?? this.defectDepthFrom,
        defectDepthTo: defectDepthTo ?? this.defectDepthTo,
        result: result ?? this.result,
        remark: remark ?? this.remark,
        inspectors: inspectors ?? this.inspectors,
        manPowers: manPowers ?? this.manPowers,
        image: image ?? this.image,
        idDefects: idDefects ?? this.idDefects,
      );

  factory TransferCheckPoint.fromJson(Map<String, dynamic> json) =>
      TransferCheckPoint(
        id: json["id"],
        routeId: json["routeId"],
        sequence: json["sequence"],
        defectLength: json["defectLength"],
        defectDepthFrom: json["defectDepthFrom"],
        defectDepthTo: json["defectDepthTo"],
        result: json["result"],
        remark: json["remark"],
        inspectors: List<Inspector>.from(
            json["inspectors"].map((x) => Inspector.fromJson(x))),
        manPowers: List<Inspector>.from(
            json["manPowers"].map((x) => Inspector.fromJson(x))),
        image: json["image"],
        idDefects: List<dynamic>.from(json["idDefects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "routeId": routeId,
        "sequence": sequence,
        "defectLength": defectLength,
        "defectDepthFrom": defectDepthFrom,
        "defectDepthTo": defectDepthTo,
        "result": result,
        "remark": remark,
        "inspectors": List<dynamic>.from(inspectors.map((x) => x.toJson())),
        "manPowers": List<dynamic>.from(manPowers.map((x) => x.toJson())),
        "image": image,
        "idDefects": List<dynamic>.from(idDefects.map((x) => x)),
      };
}

class Inspector {
  Inspector({
    this.name,
    this.nrp,
    this.image,
  });

  String name;
  String nrp;
  String image;

  Inspector copyWith({
    String name,
    String nrp,
    String image,
  }) =>
      Inspector(
        name: name ?? this.name,
        nrp: nrp ?? this.nrp,
        image: image ?? this.image,
      );

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        name: json["name"],
        nrp: json["nrp"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nrp": nrp,
        "image": image,
      };
}
