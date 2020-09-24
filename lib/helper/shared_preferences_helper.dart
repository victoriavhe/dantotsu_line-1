import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  final String tokenId = "tokenId";
  final String lastSavedToken = "lastSavedToken";

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenId) ?? '';
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(lastSavedToken, DateTime
        .now()
        .millisecondsSinceEpoch);
    return prefs.setString(tokenId, value);
  }

  Future<DateTime> getLastSavedToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var epoch = prefs.getInt(lastSavedToken);
    if (epoch == null) {
      return null;
    } else {
      return DateTime.fromMillisecondsSinceEpoch(epoch);
    }
  }


  final String userName = "userName";

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  Future<bool> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, value);
  }

  final String password = "password";

  Future<String> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  Future<bool> setPassword(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, value);
  }

  final String isFirstSeen = "isFirstSeen";

  Future<bool> getIsFirstSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstSeen) ?? '';
  }

  Future<bool> setIsFirstSeen(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isFirstSeen, value);
  }

  final String host = "host";

  Future<String> getHost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(host) ?? '';
  }

  Future<bool> setHost(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(host, value);
  }

  final String hostPort = "hostPort";

  Future<String> getHostPort() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(hostPort) ?? '';
  }

  Future<bool> setHostPort(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(hostPort, value);
  }

  final String socketPort = "socketPort";

  Future<String> getSocketPort() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(socketPort) ?? '';
  }

  Future<bool> setSocketPort(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(socketPort, value);
  }

}