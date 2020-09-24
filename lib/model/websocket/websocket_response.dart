// To parse this JSON data, do
//
//     final webSocketResponse = webSocketResponseFromJson(jsonString);

import 'dart:convert';

WebSocketResponse webSocketResponseFromJson(String str) =>
    WebSocketResponse.fromJson(json.decode(str));

String webSocketResponseToJson(WebSocketResponse data) =>
    json.encode(data.toJson());

class WebSocketResponse {
  WebSocketResponse({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory WebSocketResponse.fromJson(Map<String, dynamic> json) =>
      WebSocketResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.url,
  });

  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
