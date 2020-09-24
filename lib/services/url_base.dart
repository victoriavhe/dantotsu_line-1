import 'package:dantotsu_line/helper/shared_preferences_helper.dart';

//const String urlBase = "http://192.168.1.188:3002/v1";
//const String urlBase = "http://192.168.1.189:3002/v1";
//const String urlBase = "http://192.168.1.45:3002/v1";
//const String urlBase = "http://192.168.1.178:3002/v1";

SharedPrefsHelper _prefsHelper = SharedPrefsHelper();

String host, hostPort, socketPort;

String getHost() {
  _prefsHelper.getHost().then((value) {
    host = value;
  });
  print(host);
  return host;
}

String getHostPort() {
  _prefsHelper.getHostPort().then((value) {
    hostPort = value;
  });
  print(hostPort);
  return hostPort;
}

String getSocketPort() {
  _prefsHelper.getSocketPort().then((value) {
    socketPort = value;
  });
  print(socketPort);
  return socketPort;
}

Future<String> baseUrl() async {
  return "http://${await _prefsHelper.getHost()}:${await _prefsHelper.getHostPort()}/v1";
}
