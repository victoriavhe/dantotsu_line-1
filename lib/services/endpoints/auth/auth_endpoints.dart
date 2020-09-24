import 'package:dantotsu_line/services/url_base.dart';

class AuthenticationEndpoints {



  static Future<String> postLoginEndpoint() async {
//    return "$baseUrl"
    return "${await baseUrl()}"
        "/user/login";
  }

  static Future<String> postLogoutEndpoint() async {
    return "${await baseUrl()}"
        "/user/logout";
  }
}















