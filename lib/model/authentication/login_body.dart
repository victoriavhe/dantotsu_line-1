// To parse this JSON data, do
//
//     final loginBody = loginBodyFromJson(jsonString);

import 'dart:convert';

LoginBody loginBodyFromJson(String str) => LoginBody.fromJson(json.decode(str));

String loginBodyToJson(LoginBody data) => json.encode(data.toJson());

class LoginBody {
  LoginBody({
    this.userName,
    this.password,
  });

  String userName;
  String password;

  factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'password': password,
  };
}
