// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());



class LoginResponse {
  LoginResponse({
    this.result,
    this.message,
    this.data,
  });

  String result;
  String message;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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

class LoginErrorResp {
  LoginErrorResp({
    this.result,
    this.message,
  });

  String result;
  String message;

  factory LoginErrorResp.fromJson(Map<String, dynamic> json) => LoginErrorResp(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}


class Data {
  Data({
    this.token,
    this.username,
    this.privilege,
    this.name,
    this.jobdesk,
    this.image,
  });

  String token;
  String username;
  String privilege;
  String name;
  String jobdesk;
  String image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        username: json["username"],
        privilege: json["privilege"],
        name: json["name"],
        jobdesk: json["jobdesk"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "privilege": privilege,
        "name": name,
        "jobdesk": jobdesk,
        "image": image,
      };
}
