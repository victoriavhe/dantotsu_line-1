import 'package:dantotsu_line/helper/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

SharedPrefsHelper _sharedPrefsHelper = SharedPrefsHelper();

Future<http.Response> makePostRequest(String url, map) async {
  print("[POST] $url");
  print("[BODY] $map");

  var response = await http.post(
    url,
    body: map,
    headers: {"Content-Type": "application/json"},
  );

  _printResponse("[RESPONSE] ${response.body}");
  //printLoggerIfError
  return response;
}

Future<http.Response> makeLogoutRequest(String url) async {
  print("[POST] $url");

  var response = await http.post(
    url,
    headers: await getHeaderAuthorization(),
  );

  _printResponse("[RESPONSE] ${response.body}");
  //printLoggerIfError
  return response;
}

Future<http.Response> makeGetRequest(String url) async {
  print(await getHeaderAuthorization());
  print("[GET] $url");

  var response = await http.get(
    url,
    headers: await getHeaderAuthorization(),
  );

  _printResponse(response.body);
  //printLoggerIfError
  return response;
}

Future<http.Response> makePostWithTokenRequest(String url, map) async {
  print("[POST] $url");
  print("[BODY] ${json.encode(map)}");

  var response = await http.post(
    url,
    body: map,
    headers: await getHeaderAuthorization(),
  );

  _printResponse("[RESPONSE] ${response.body}");
  //printLoggerIfError
  return response;
}




Future _printResponse(String response) async {
//  JsonEncoder encoder = JsonEncoder.withIndent("   ");
//  String prettyPrint = encoder.convert(jsonDecode(response));

  var split = response.split("\n");

  debugPrint(response);
  if (split.length <= 200) {
  } else {
    debugPrint(split.sublist(0, 60).join("\n"));
    var printNext =
    split.sublist(60).map((s) => s.replaceAll(' ', "")).join("");
    debugPrint("... $printNext");
  }
}

Future<String> _getUserToken(isForceRefresh) async {
  String apiKey;
  var savedToken = (await _sharedPrefsHelper.getToken()) ?? "";
  print("savedToken = $savedToken");
  if (savedToken.isNotEmpty && !isForceRefresh) {
    var lastSavedToken = await _sharedPrefsHelper.getLastSavedToken();
    print("lastSaved on $lastSavedToken");
    var duration = DateTime.now().difference(lastSavedToken).inMinutes;
    print("saved on $duration minutes ago");
    if (duration > 45) {
      print("refresh token");
    } else {
      apiKey = savedToken;
    }
  }
  return apiKey;
}

Future<Map<String, String>> getHeaderAuthorization({
  bool forceRefreshToken = false,
}) async {
  var startFunc = DateTime.now();
  var token = await _getUserToken(forceRefreshToken);

  var header = {
    'Authorization': "Bearer $token",
    "Content-Type": "application/json"
  };
  var end = DateTime.now().difference(startFunc);
  print("Generate full header need ${end.inMilliseconds} ms");
  printHeader(header);
  return header;
}

Future<void> printHeader(Map<String, String> header) async {
  var start = DateTime.now();
  header.forEach((key, value) {
    for (var i = 0; i < value.length; i += 250) {
      print(
          "--> $key: ${value.substring(i, value.length > i + 250 ? i + 250 : value.length)}");
    }
  });
  var end = DateTime.now().difference(start);
  print("Print header need ${end.inMilliseconds} ms");
}
