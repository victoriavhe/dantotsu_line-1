
import 'package:dantotsu_line/helper/http_helper.dart';
import 'package:dantotsu_line/model/authentication/login_body.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/authentication/logout_response.dart';
import 'package:dantotsu_line/services/endpoints/auth/auth_endpoints.dart';

class AuthenticationAPI {
  Future<LoginResponse> postLogin(LoginBody body) async {


    final response = await makePostRequest(
        await AuthenticationEndpoints.postLoginEndpoint(), loginBodyToJson(body));

    return loginResponseFromJson(response.body);
  }

  //TODO: Logout body ??
  Future<LogoutResponse> postLogout() async {
    final response = await makeLogoutRequest(
        await AuthenticationEndpoints.postLogoutEndpoint());

    return logoutResponseFromJson((response.body));
  }
}
