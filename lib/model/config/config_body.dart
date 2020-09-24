// To parse this JSON data, do
//
//     final configUpdate = configUpdateFromJson(jsonString);

import 'dart:convert';

ConfigUpdate configUpdateFromJson(String str) => ConfigUpdate.fromJson(json.decode(str));

String configUpdateToJson(ConfigUpdate data) => json.encode(data.toJson());

class ConfigUpdate {
  ConfigUpdate({
    this.host,
    this.hostPort,
    this.socketPort,
  });

  String host;
  String hostPort;
  String socketPort;

  factory ConfigUpdate.fromJson(Map<String, dynamic> json) => ConfigUpdate(
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
