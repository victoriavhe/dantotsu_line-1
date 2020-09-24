// To parse this JSON data, do
//
//     final groupLeaderCpResponse = groupLeaderCpResponseFromJson(jsonString);

import 'dart:convert';

GroupLeaderCpResponse groupLeaderCpResponseFromJson(String str) => GroupLeaderCpResponse.fromJson(json.decode(str));

String groupLeaderCpResponseToJson(GroupLeaderCpResponse data) => json.encode(data.toJson());

class GroupLeaderCpResponse {
  GroupLeaderCpResponse({
    this.result,
    this.message,
  });

  String result;
  String message;

  GroupLeaderCpResponse copyWith({
    String result,
    String message,
  }) =>
      GroupLeaderCpResponse(
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory GroupLeaderCpResponse.fromJson(Map<String, dynamic> json) => GroupLeaderCpResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
