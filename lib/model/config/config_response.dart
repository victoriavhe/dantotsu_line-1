// To parse this JSON data, do
//
//     final configResponse = configResponseFromJson(jsonString);

import 'dart:convert';

ConfigResponse configResponseFromJson(String str) => ConfigResponse.fromJson(json.decode(str));

String configResponseToJson(ConfigResponse data) => json.encode(data.toJson());

class ConfigResponse {
  ConfigResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory ConfigResponse.fromJson(Map<String, dynamic> json) => ConfigResponse(
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
    this.host,
    this.hostPort,
    this.socketPort,
  });

  String host;
  String hostPort;
  String socketPort;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    host: json["host"],
    hostPort: json["hostPort"],
    socketPort: json["socketPort"],
  );

  Map<String, dynamic> toJson() => {
    "host": host,
    "hostPort": hostPort,
    "socketPort": socketPort,
  };
}
